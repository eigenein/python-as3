package game.view.gui.overlay
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.homescreen.PlayerStatsPanelMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObject;
   import game.model.GameModel;
   import game.model.user.specialoffer.SpecialOfferViewSlot;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.common.resourcepanel.PopupResourcePanelLarge;
   
   public class PlayerStatsPanel extends LayoutGroup implements ITutorialActionProvider
   {
       
      
      private var mediator:PlayerStatsPanelMediator;
      
      private var resourcePanels:Vector.<PopupResourcePanelLarge>;
      
      private var slotStarmoney:SpecialOfferViewSlot;
      
      public function PlayerStatsPanel(param1:PlayerStatsPanelMediator)
      {
         resourcePanels = new Vector.<PopupResourcePanelLarge>();
         super();
         this.mediator = param1;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButton(TutorialNavigator.BILLING,getButtonByResource(DataStorage.pseudo.STARMONEY));
         _loc2_.addButton(TutorialNavigator.ALCHEMY,getButtonByResource(DataStorage.pseudo.COIN));
         _loc2_.addButton(TutorialNavigator.REFILL_ENERGY,getButtonByResource(DataStorage.pseudo.STAMINA));
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 10;
         _loc1_.paddingRight = 10;
         layout = _loc1_;
         var _loc2_:int = mediator.resourceDataGroup.data.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = AssetStorage.rsx.popup_theme.create(PopupResourcePanelLarge,"resource_panel");
            _loc5_.signal_resize.add(handler_resize);
            _loc4_ = mediator.resourceDataGroup.data[_loc3_];
            _loc5_.data = _loc4_;
            resourcePanels.push(_loc5_);
            addChild(_loc5_.graphics);
            if(_loc4_.item == DataStorage.pseudo.STARMONEY)
            {
               slotStarmoney = new SpecialOfferViewSlot(_loc5_.tf_value,GameModel.instance.player.specialOffer.hooks.homeScreenStarmoney);
            }
            mediator.specialOfferHooks.registerResourcePanel(_loc5_);
            _loc3_++;
         }
         Tutorial.addActionsFrom(this);
      }
      
      private function getButtonByResource(param1:InventoryItemDescription) : PopupResourcePanelLarge
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_resize() : void
      {
         invalidate("size");
      }
   }
}
