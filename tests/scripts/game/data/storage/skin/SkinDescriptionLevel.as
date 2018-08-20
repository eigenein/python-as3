package game.data.storage.skin
{
   import game.data.cost.CostData;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   
   public class SkinDescriptionLevel
   {
       
      
      public var id:uint;
      
      public var cost:CostData;
      
      public var statBonus:BattleStatValueObject;
      
      public function SkinDescriptionLevel()
      {
         super();
      }
      
      public function deserialize(param1:Object) : void
      {
         var _loc2_:* = false;
         this.id = param1.level;
         if(param1.cost)
         {
            cost = new CostData(param1.cost);
         }
         if(param1.statBonus)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1.statBonus;
            for(var _loc3_ in param1.statBonus)
            {
               _loc2_ = _loc3_ == "lifesteal";
               statBonus = new BattleStatValueObject(_loc3_,param1.statBonus[_loc3_],param1.statBonus[_loc3_] is int,_loc2_);
            }
         }
      }
   }
}
