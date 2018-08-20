package game.mediator.gui.popup.hero
{
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.consumable.HeroUseXPConsumableNotEnoughPopup;
   
   public class HeroUseXPConsumableNotEnoughPopupMediator extends PopupMediator
   {
       
      
      public function HeroUseXPConsumableNotEnoughPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      public function action_toMissions() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.MISSION,Stash.click("campaign",popup.stashParams));
         close();
      }
      
      public function action_toShop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getById(1) as ShopDescription;
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,popup.stashParams));
         close();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroUseXPConsumableNotEnoughPopup(this);
         return new HeroUseXPConsumableNotEnoughPopup(this);
      }
   }
}
