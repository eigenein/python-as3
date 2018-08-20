package game.battle.view.systems
{
   import battle.data.BattleSkillDescription;
   import game.battle.view.BattleSceneObject;
   import game.battle.view.ult.UltAnimationController;
   
   public class BattleSkillFxSystem extends BattleUpdateSystem
   {
       
      
      private var ultAnimationController:UltAnimationController;
      
      private var v:Vector.<BattleSceneObject>;
      
      public function BattleSkillFxSystem(param1:UltAnimationController)
      {
         v = new Vector.<BattleSceneObject>();
         super(null);
         this.ultAnimationController = param1;
      }
      
      override protected function get collection() : Vector.<*>
      {
         return v as Vector.<*>;
      }
      
      override public function getComponentToHandle(param1:BattleSceneObject) : *
      {
         return param1;
      }
      
      override public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(ultAnimationController.timeStopped)
         {
            _loc4_ = v.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc2_ = v[_loc3_];
               if(_loc2_.skill && _loc2_.skill.tier == BattleSkillDescription.TIER_ULTIMATE && ultAnimationController.getSkillIsInCast(_loc2_.skill))
               {
                  _loc2_.advanceTime(param1);
               }
               else if(_loc2_.tickOnPause)
               {
                  _loc2_.advanceTime(param1);
               }
               _loc3_++;
            }
         }
         else
         {
            _loc4_ = v.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               v[_loc3_].advanceTime(param1);
               _loc3_++;
            }
         }
      }
   }
}
