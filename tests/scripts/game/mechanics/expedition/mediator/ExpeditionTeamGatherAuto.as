package game.mechanics.expedition.mediator
{
   import flash.utils.getTimer;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   
   public class ExpeditionTeamGatherAuto
   {
       
      
      private const MAX_INDEX:int = 4;
      
      private var list:Vector.<TeamGatherPopupHeroValueObject>;
      
      private var minPower:Number = Infinity;
      
      private var power:Number;
      
      private var minPowerTeam:Vector.<int>;
      
      private var currentTeam:Vector.<int>;
      
      public function ExpeditionTeamGatherAuto(param1:Vector.<TeamGatherPopupHeroValueObject>, param2:Number)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get hasResult() : Boolean
      {
         return minPowerTeam != null;
      }
      
      public function get team() : Vector.<TeamGatherPopupHeroValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function recursive(param1:int, param2:Number, param3:int, param4:int) : void
      {
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc7_:Number = NaN;
         _loc6_ = param3;
         while(_loc6_ < param4)
         {
            currentTeam[param1] = _loc6_;
            _loc5_ = list[_loc6_];
            _loc7_ = param2 + _loc5_.power;
            if(param1 == 4)
            {
               if(_loc7_ >= this.power)
               {
                  if(_loc7_ < minPower)
                  {
                     minPower = _loc7_;
                     minPowerTeam = currentTeam.concat();
                  }
                  else
                  {
                     return;
                  }
               }
            }
            else
            {
               recursive(param1 + 1,_loc7_,_loc6_ + 1,param4);
            }
            _loc6_++;
         }
      }
   }
}
