package battle
{
   import battle.logic.PrimeRange;
   import battle.skills.Skill;
   import flash.Boot;
   
   public class BattlePrint
   {
       
      
      public var engine:BattleEngine;
      
      public var currentTime:Number;
      
      public function BattlePrint(param1:BattleEngine = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         currentTime = 0;
         engine = param1;
      }
      
      public function stupidSort(param1:Vector.<Hero>) : void
      {
         var _loc2_:* = null as Hero;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         while(true)
         {
            _loc4_++;
            if(_loc4_ >= _loc5_)
            {
               break;
            }
            _loc2_ = param1[_loc4_];
            _loc3_ = _loc4_;
            while(_loc3_ > 0 && param1[_loc3_ - 1].body.x > _loc2_.body.x)
            {
               param1[_loc3_] = param1[_loc3_ - 1];
               _loc3_--;
            }
            param1[_loc3_] = _loc2_;
         }
      }
      
      public function spanColor(param1:String, param2:String, param3:String = undefined, param4:Boolean = false) : String
      {
         if(param3 == null)
         {
            param3 = "#eee";
         }
         return "<span style=\'background:" + param3 + ";color:" + param1 + (!!param4?";font-weight:bold":"") + "\'>" + param2 + "</span>";
      }
      
      public function heroMovementMark(param1:Hero) : String
      {
         if(param1.body.vx > 0)
         {
            return ">";
         }
         if(param1.body.vx < 0)
         {
            return "<";
         }
         if(param1.skills.getAutoAttack().range != null && param1.skills.getAutoAttack().range.isOccupied())
         {
            return " ";
         }
         return "!";
      }
   }
}
