<?php
/**
 * Created by PhpStorm.
 * User: mauriciohimaker
 * Date: 7/26/17
 * Time: 20:55
 */
namespace App\Entity\Repository;

use Doctrine\ORM\EntityRepository;

class User extends EntityRepository  {

    public function authenticate($apikey)
    {
        $user = $this->findOneBy(array('apikey' => $apikey));
        if(!is_null($user)){
            return $user;

        }
        return false;
    }

}
