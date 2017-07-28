<?php
/**
 * Created by PhpStorm.
 * User: mauriciohimaker
 * Date: 7/26/17
 * Time: 22:55
 */
namespace App\Entity\Repository;

use Doctrine\ORM\EntityRepository;

class Task extends EntityRepository  {

    public function getAllByUser($user)
    {
        $qb = $this->_em->createQueryBuilder();
        $tasks = $qb->select('t')
            ->from('App\Entity\Task', 't')
            ->where('t.user = :user')
            ->setParameter('user', $user)
            ->orderBy('t.sequence', 'desc')
            ->addOrderBy('t.id', 'desc')
            ->getQuery()
            ->getResult(\Doctrine\ORM\Query::HYDRATE_ARRAY);

        if(!empty($tasks)){
            return $tasks;
        }
        return false;
    }

    public function getByUserAndId($user, $id)
    {
        $qb = $this->_em->createQueryBuilder();
        $task = $qb->select('t')
            ->from('App\Entity\Task', 't')
            ->where('t.id = :id')
            ->andWhere('t.user = :user')
            ->setParameter('id', $id)
            ->setParameter('user', $user)
            ->orderBy('t.sequence', 'desc')
            ->addOrderBy('t.id', 'desc')
            ->getQuery();

        try {
            $task = $task->getSingleResult(\Doctrine\ORM\Query::HYDRATE_ARRAY);
        }
        catch(\Doctrine\ORM\NoResultException $e) {
            $task = null;
        }

        if(!is_null($task)){
            return $task;
        }

        return false;
    }

    public function changeOrder($order){
        $count = 1;
        foreach ($order as $item){
            $qb = $this->_em->createQueryBuilder();
            $result = $qb->update('App\Entity\Task', 't')
                ->set('t.sequence', $count)
                ->where('t.id = ?1')
                ->setParameter(1, $item)
                ->getQuery();
            try{
                $result->execute();
            }catch (\Exception $ex){
                return false;
            }
            $count++;
        }

        return true;
    }
}
