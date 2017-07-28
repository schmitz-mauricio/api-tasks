<?php
/**
 * Created by PhpStorm.
 * User: mauricioschmitz
 * Date: 7/27/17
 * Time: 20:15
 */
$baseDir = __DIR__;
$loader = require $baseDir . '/vendor/autoload.php';
use Doctrine\Common\Annotations\AnnotationRegistry;
use Silex\Provider\DoctrineServiceProvider;
use Dflydev\Provider\DoctrineOrm\DoctrineOrmServiceProvider;

AnnotationRegistry::registerLoader([$loader, 'loadClass']);
$app->register(
    new DoctrineServiceProvider(),
    [
        'db.options' => [
            'driver'        => 'pdo_mysql',
            'host'          => 'localhost',
            'dbname'        => 'u112741921_tasks',
            'user'          => 'u112741921_tasks',
            'password'      => 'tasks123',
            'charset'       => 'utf8',
            'driverOptions' => [
                1002 => 'SET NAMES utf8',
            ],
        ],
    ]
);
$app->register(new DoctrineOrmServiceProvider(), [
    'orm.proxies_dir'             => $baseDir . 'src/Entity/Proxy',
    'orm.auto_generate_proxies'   => $app['debug'],
    'orm.em.options'              => [
        'mappings' => [
            [
                'type'                         => 'annotation',
                'namespace'                    => 'App\\Entity\\',
                'path'                         => $baseDir. 'src/Entity',
                'use_simple_annotation_reader' => false,
            ],
        ],
    ]
]);

?>