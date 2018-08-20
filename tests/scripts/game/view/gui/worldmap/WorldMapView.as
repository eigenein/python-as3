package game.view.gui.worldmap
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipFactory;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.worldmap.WorldMapListValueObject;
   import game.mediator.gui.worldmap.WorldMapViewMediator;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.homescreen.ShopHoverSound;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialButton;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class WorldMapView extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
      
      private static var _music:ShopHoverSound;
       
      
      private var guiAsset:WorldMapGUIAsset;
      
      private var mediator:WorldMapViewMediator;
      
      private var map_container:WorldMapViewScrollContainer;
      
      private var asset_controls:WorldMapControlsGuiClip;
      
      private var toggleGroup:ToggleGroup;
      
      public function WorldMapView(param1:WorldMapViewMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "campaign";
         param1.signal_worldSelect.add(handler_worldSelected);
      }
      
      public static function get music() : ShopHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(0.5,1.5,AssetStorage.sound.portalHover);
         }
         return _music;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _music.shopClosed();
         map_container.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.WORLD_MAP;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc3_.addCloseButton(asset_controls.close);
         var _loc2_:MissionDescription = param1.mission;
         if(!_loc2_)
         {
            return _loc3_;
         }
         var _loc4_:ITutorialButton = null;
         if(_loc2_.world < mediator.worldMap.desc.id)
         {
            _loc4_ = asset_controls.arrow_prev;
         }
         else if(_loc2_.world > mediator.worldMap.desc.id)
         {
            _loc4_ = asset_controls.arrow_next;
         }
         if(_loc4_)
         {
            _loc3_.addButton(TutorialNavigator.MISSION,_loc4_);
         }
         return _loc3_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _music.shopOpen();
         guiAsset = AssetStorage.rsx.world_map;
         if(guiAsset.completed)
         {
            _initialize(guiAsset);
         }
         else
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(guiAsset,_initialize);
         }
      }
      
      protected function _initialize(param1:RsxGameAsset) : void
      {
         var _loc3_:ClipSprite = guiAsset.create_map_background();
         addChild(_loc3_.graphics);
         map_container = new WorldMapViewScrollContainer(mediator.listCollection);
         var _loc4_:int = 1000;
         map_container.width = _loc4_;
         width = _loc4_;
         _loc4_ = 640;
         map_container.height = _loc4_;
         height = _loc4_;
         addChild(map_container);
         var _loc2_:GuiClipFactory = new GuiClipFactory();
         asset_controls = new WorldMapControlsGuiClip();
         _loc2_.create(asset_controls,param1.data.getClipByName("map_controls"));
         addChild(asset_controls.graphics);
         asset_controls.close.signal_click.add(close);
         asset_controls.arrow_next.signal_click.add(handlerNavigationFwdClick);
         asset_controls.arrow_prev.signal_click.add(handlerNavigationBackClick);
         map_container.jumpToWorld(mediator.worldMap);
         createMap();
      }
      
      private function createMap() : void
      {
         asset_controls.mapTitle.text = mediator.title;
         asset_controls.arrow_next.graphics.visible = mediator.nextWorld;
         asset_controls.arrow_prev.graphics.visible = mediator.prevWorld;
      }
      
      private function handlerMissionClick(param1:WorldMapMissionButton) : void
      {
         mediator.action_selectMission(param1.data);
      }
      
      private function handlerNavigationBackClick() : void
      {
         mediator.action_navigateBack();
      }
      
      private function handlerNavigationFwdClick() : void
      {
         mediator.action_navigateForward();
      }
      
      private function handler_worldSelected(param1:WorldMapListValueObject) : void
      {
         createMap();
         map_container.scrollToWorld(param1);
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_modeSelected() : void
      {
         createMap();
      }
   }
}
