<?php
/**
 * Created by PhpStorm.
 * User: mauricioschmitz
 * Date: 7/27/17
 * Time: 22:10
 */

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use App\Middleware\Logging as AppLogging;
use App\Middleware\Authentication as AppAuth;
use App\Entity\Task;
use App\Entity\User;

$em = $app['orm.em'];

$app->after(function (Request $request, Response $response) {
    $response->headers->set('Access-Control-Allow-Origin', '*');
});
//Authentication;
$app->before(function($request, $app) use ($app, $em) {
    //Verify if content type is json
    if (strpos($request->headers->get('Content-Type'), 'application/json')!==0) {
        return $app->json(array('error' => 'Invalid Header Content-Type'), 201);
    }else{
        $data = json_decode($request->getContent(), true);
        $request->request->replace(is_array($data) ? $data : array());
    }

    //Log usage
    AppLogging::log($request, $app);
    //Authenticate
    AppAuth::authenticate($request, $app);
});


//Group api routes
$app->mount('/api/v1', function ($api) use ($app, $em){
    $app->match("{url}", function($url) use ($app) { return "OK"; })->assert('url', '.*')->method("OPTIONS");

    //List of messages from user request
    $api->get('/tasks', function (Request $request)  use ($app, $em) {
        //find taks from authenticated user
        $tasks = $em->getRepository(Task::class)->getAllByUser($request->attributes->get('user'));

        //return a json result
        return $app->json($tasks, 201);
    });

    //Find one task by id
    $api->get('/task/{id}', function (Request $request, $id)  use ($app, $em) {
        //find task from authenticated user and request id
        $task = $em->getRepository(Task::class)->getByUserAndId($request->attributes->get('user'), $id);
//        //return a json result
        return $app->json($task, 201);
    });

    //Create a task from user request
    $api->post('/task', function (Request $request)  use ($app, $em) {
        try{
            $task = new Task();
            $task->setUser($request->attributes->get('user'));
            $task->setTitle($request->get('title'));
            $task->setDescription($request->get('description'));
            if(!is_null($request->get('done')))
                $task->setDone($request->get('done'));

            $em->persist($task);
            $em->flush();

            $task = $em->getRepository(Task::class)->getByUserAndId($request->attributes->get('user'), $task->getId());
            return $app->json($task, 201);

        }catch (Exception $ex){
            var_dump($ex->getMessage());die;
            return $app->json(array('error' => 'Invalid data sent'), 201);
        }
    });

    //Update a task from user request
    $api->put('/task', function (Request $request)  use ($app, $em) {
        $task = $em->getRepository(Task::class)->findOneBy(array('id' => $request->request->get('id'), 'user' => $request->attributes->get('user')));
        if($task){
            try{
                if(!is_null($request->get('title')))
                    $task->setTitle($request->get('title'));

                if(!is_null($request->get('description')))
                    $task->setDescription($request->get('description'));

                if(!is_null($request->get('done')))
                    $task->setDone($request->get('done'));

                $em->persist($task);
                $em->flush();

            }catch (Exception $ex){
                return $app->json(array('error' => 'An error ocurred, please check the API documentation'), 201);

            }
            return $app->json(array('success' => 'Update'), 201);
        }else{
            return $app->json(array('error' => 'Task not found'), 201);
        }
    });

    //Delete one task by id
    $api->delete('/task/{id}', function (Request $request, $id)  use ($app, $em) {
        //find task from authenticated user and request id
        $task = $em->getRepository(Task::class)->findOneBy(array('id' => $id, 'user' => $request->attributes->get('user')));
        if($task){
            $em->remove($task);
            $em->flush();
            return $app->json(array('success' => 'Deleted'), 201);
        }else{
            return $app->json(array('error' => 'Task not found'), 201);
        }

    });

    //Change order
    $api->put('/tasks', function (Request $request)  use ($app, $em) {
        $task = $em->getRepository(Task::class)->changeOrder(array_reverse($request->get('tasks')));
        if($task){
            return $app->json(array('success' => 'Tasks reordered'), 201);
        }else{
            return $app->json(array('error' => 'Tasks not reordered'), 201);
        }
    });
});


$app->error(function (\Exception $e, Request $request, $code) use ($app) {
    if ($app['debug']) {
        return;
    }

    return $app->json(array('error' => 'An error ocurred, please check the API documentation'), $code);
});
