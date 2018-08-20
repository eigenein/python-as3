package game.battle.controller
{
   import battle.objects.BattleEntity;
   import battle.objects.ProjectileEntity;
   import battle.skills.Effect;
   import flash.utils.Dictionary;
   import game.battle.controller.entities.BattleEffect;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.entities.BattleProjectile;
   import game.battle.controller.entities.IBattleEntityMediator;
   
   public class BattleEntityMediators
   {
       
      
      private var entitiesMapping:Dictionary;
      
      public function BattleEntityMediators()
      {
         entitiesMapping = new Dictionary();
         super();
      }
      
      public function getHero(param1:BattleEntity) : BattleHero
      {
         return entitiesMapping[param1] as BattleHero;
      }
      
      public function getEffect(param1:Effect) : BattleEffect
      {
         return entitiesMapping[param1] as BattleEffect;
      }
      
      public function getProjectile(param1:ProjectileEntity) : BattleProjectile
      {
         return entitiesMapping[param1] as BattleProjectile;
      }
      
      public function add(param1:BattleEntity, param2:IBattleEntityMediator) : void
      {
         entitiesMapping[param1] = param2;
         param1.onRemove.add(handler_removeEntity);
         param2.setEntity(param1);
      }
      
      public function clear() : void
      {
         entitiesMapping = new Dictionary();
      }
      
      private function handler_removeEntity(param1:BattleEntity) : void
      {
         var _loc2_:IBattleEntityMediator = entitiesMapping[param1];
         if(!_loc2_)
         {
            return;
         }
         delete entitiesMapping[param1];
         _loc2_.removeEntity();
      }
   }
}
