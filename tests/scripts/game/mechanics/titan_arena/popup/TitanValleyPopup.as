package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.TitanValleyPopupMediator;
   import game.mediator.gui.RedMarkerState;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class TitanValleyPopup extends AsyncClipBasedPopupWithPreloader implements ITutorialActionProvider, ITutorialNodePresenter
   {
      
      public static const ASSET_IDENT:String = "dialog_spirit_valley";
       
      
      private var mediator:TitanValleyPopupMediator;
      
      private var clip:TitanValleyPopupClip;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanValleyPopup(param1:TitanValleyPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName("dialog_spirit_valley"));
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.getByName("dialog_spirit_valley"),AssetStorage.rsx.getByName("big_pillars"));
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
         this.mediator = param1;
         param1.signal_spiritsUpdate.add(handler_spiritsUpdate);
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         _loc2_.addButton(TutorialNavigator.TITAN_VALLEY_ALTAR,clip.btn_altar);
         _loc2_.addButton(TutorialNavigator.TITAN_VALLEY_ARTIFACTS,clip.btn_temple);
         _loc2_.addButton(TutorialNavigator.TITAN_VALLEY_ARENA,clip.btn_arena);
         _loc2_.addButton(TutorialNavigator.TITAN_VALLEY_MERCHANT,clip.btn_merchant);
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         width = 1000;
         height = 640;
         clip = param1.create(TitanValleyPopupClip,"spirit_valley_popup");
         addChild(clip.graphics);
         clip.btn_hall_of_fame.label = Translate.translate("UI_SPIRIT_VALLEY_POPUP_HALL_OF_FAME");
         clip.btn_hall_of_fame.redMarkerState = mediator.titanArenaRewardMarkerState;
         clip.btn_hall_of_fame.signal_click.add(mediator.action_navigate_hall_of_fame);
         clip.btn_arena.label = Translate.translate("UI_SPIRIT_VALLEY_POPUP_ARENA");
         clip.btn_arena.redMarkerState = mediator.titanArenaPointsRewardMarkerState;
         clip.btn_arena.signal_click.add(mediator.action_navigate_arena);
         clip.btn_merchant.label = Translate.translate("UI_SPIRIT_VALLEY_POPUP_MERCHANT");
         clip.btn_merchant.signal_click.add(mediator.action_navigate_merchant);
         clip.btn_merchant.redMarkerState = new RedMarkerState("titanValleyMerchant");
         clip.btn_altar.label = Translate.translate("UI_SPIRIT_VALLEY_POPUP_ALTAR");
         clip.btn_altar.redMarkerState = mediator.titanArtifactChestMarkerState;
         clip.btn_altar.signal_click.add(mediator.action_navigate_altar);
         clip.btn_temple.label = Translate.translate("UI_SPIRIT_VALLEY_POPUP_TEMPLE");
         clip.btn_temple.redMarkerState = mediator.titanArtifactsMarkerState;
         clip.btn_temple.signal_click.add(mediator.action_navigate_temple);
         clip.button_fire.label = Translate.translate("UI_SPIRIT_VALLEY_POPUP_SPIRITS");
         clip.button_fire.redMarkerState = mediator.titanSpiritArtifactsMarkerState;
         clip.button_fire.signal_click.add(mediator.action_navigate_spirit_fire);
         clip.button_water.signal_click.add(mediator.action_navigate_spirit_water);
         clip.button_earth.signal_click.add(mediator.action_navigate_spirit_earth);
         clip.ground_animation_1.graphics.touchable = false;
         clip.clouds_animation_2.graphics.touchable = false;
         clip.clouds_animation_3.graphics.touchable = false;
         clip.clouds_animation_4.graphics.touchable = false;
         clip.boat_1_animation.graphics.touchable = false;
         updateSpiritTotems();
         clip.button_close.signal_click.add(mediator.close);
         Tutorial.updateActionsFrom(this);
      }
      
      private function updateSpiritTotems() : void
      {
         clip.button_earth.setEvolution("spirit_earth_" + (mediator.totemStar_earth + 1));
         clip.button_fire.setEvolution("spirit_fire_" + (mediator.totemStar_fire + 1));
         clip.button_water.setEvolution("spirit_water_" + (mediator.totemStar_water + 1));
      }
      
      private function handler_spiritsUpdate() : void
      {
         updateSpiritTotems();
      }
   }
}
