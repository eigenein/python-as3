package game.mediator.gui.popup.billing.bundle
{
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.HeroEvolveUpsellBundlePopup;
   
   public class HeroEvolveUpsellBundlePopupMediator extends GenericHeroBundlePopupMediator
   {
       
      
      private var _starCount_after:int;
      
      private var _starCount_before:int;
      
      public function HeroEvolveUpsellBundlePopupMediator(param1:Player)
      {
         super(param1);
      }
      
      public function get goldReward() : InventoryItem
      {
         return new InventoryItem(DataStorage.pseudo.COIN,bundle.reward.gold);
      }
      
      public function get starCount_after() : int
      {
         return bundle.bundleHeroReward[0].reward_star;
      }
      
      public function get starCount_before() : int
      {
         return bundle.bundleHeroReward[0].reward_star - 1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroEvolveUpsellBundlePopup(this);
         return _popup;
      }
   }
}
