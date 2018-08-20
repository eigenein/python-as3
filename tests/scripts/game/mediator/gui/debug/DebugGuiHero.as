package game.mediator.gui.debug
{
   import flash.utils.Dictionary;
   import game.data.storage.gear.GearItemDescription;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.Inventory;
   
   public class DebugGuiHero
   {
       
      
      public var actions:Dictionary;
      
      private var _slot:int;
      
      private var skillId:int;
      
      public function DebugGuiHero()
      {
         actions = new Dictionary();
         super();
         actions["traceMergedPromoInventory"] = function():void
         {
            var _loc1_:Inventory = GameModel.instance.player.inventory.getItemCollection();
            var _loc3_:PlayerHeroEntry = GameModel.instance.player.heroes.getById(1);
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_.color.itemList;
            for each(var _loc2_ in _loc3_.color.itemList)
            {
               _loc1_.addItem(_loc2_,10);
            }
         };
      }
      
      private function get slot() : int
      {
         if(_slot > 5)
         {
            _slot = 0;
         }
         _slot = Number(_slot) + 1;
         return Number(_slot);
      }
   }
}
