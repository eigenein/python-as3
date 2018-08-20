package game.assets.battle
{
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   
   public class BattlePlayerTeamIconDescription
   {
       
      
      private var map:Array;
      
      public function BattlePlayerTeamIconDescription(param1:Object)
      {
         var _loc2_:* = null;
         map = [];
         super();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            map[int(_loc3_)] = UnitUtils.createEntryValueObjectFromRawData(_loc2_);
         }
      }
      
      public function getHeroById(param1:int) : UnitEntryValueObject
      {
         return map[param1];
      }
   }
}
