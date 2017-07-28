<?php
/**
 * Created by PhpStorm.
 * User: mauricioschmitz
 * Date: 7/26/17
 * Time: 21:15
 */
namespace App\Middleware;

use App\Entity\User;

class Authentication {

    public static function authenticate($request, $app)
    {
        $em = $app['orm.em'];
        $auth = $request->headers->get("x-api-key");
        $apikey = substr($auth, strpos($auth, ' '));
        $apikey = trim($apikey);
        $check = $em->getRepository(User::class)->authenticate($apikey);
        if(!$check){
            $app->abort(401);
        }
        else $request->attributes->set('user',$check);

    }
}
?>