package game.mediator.gui.popup.hero
{
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class HeroTitanGiftLevelDropPopUpMediator extends PopupMediator
   {
       
      
      private var hero:PlayerHeroEntry;
      
      public function HeroTitanGiftLevelDropPopUpMediator(param1:Player, param2:PlayerHeroEntry)
      {
         super(param1);
         this.hero = param2;
      }
      
      public function get spentTitanSparks() : InventoryItem
      {
         var _loc1_:InventoryItem = new InventoryItem(DataStorage.consumable.getTitanSparkDesc(),hero.titanCoinsSpent);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroTitanGiftLevelDropPopUp(this);
         return new HeroTitanGiftLevelDropPopUp(this);
      }
      
      public function action_continue() : void
      {
         close();
      }
      
      public function action_drop() : void
      {
         GameModel.instance.actionManager.hero.heroTitanGiftDrop(hero);
         close();
      }
   }
}
