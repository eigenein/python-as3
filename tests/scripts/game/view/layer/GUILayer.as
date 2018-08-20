package game.view.layer
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.Label;
   import feathers.controls.LayoutGroup;
   import feathers.layout.AnchorLayout;
   import feathers.layout.AnchorLayoutData;
   import feathers.layout.HorizontalLayout;
   import feathers.textures.Scale3Textures;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mediator.gui.GUILayerMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.gui.homescreen.HomeScreenClanMenu;
   import game.view.gui.overlay.PlayerStatsPanel;
   import game.view.gui.overlay.offer.SpecialOfferSideBar;
   import game.view.popup.theme.LabelStyle;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.textures.Texture;
   
   public class GUILayer extends LayoutGroup
   {
       
      
      private var vect:Vector.<Texture>;
      
      private var upSkinTex:Scale3Textures;
      
      private var downSkinTex:Scale3Textures;
      
      private var buttons:Dictionary;
      
      private var group:LayoutGroup;
      
      private var subGroup:ButtonGroup;
      
      private var console:Label;
      
      private var dictKey:String;
      
      private var time:Label;
      
      private var mediator:GUILayerMediator;
      
      private var fullScreenButtonOn:ClipButton;
      
      private var fullScreenButtonOff:ClipButton;
      
      public var buttonSignal:Signal;
      
      public function GUILayer(param1:GUILayerMediator)
      {
         buttonSignal = new Signal(String,String);
         super();
         this.mediator = param1;
         param1.signal_playerInit.addOnce(onPlayerInit);
         param1.signal_fullScreenStateChange.add(handler_fullScreenStateChange);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = Starling.current.stage.stageWidth;
         height = Starling.current.stage.stageHeight;
         var _loc6_:AnchorLayout = new AnchorLayout();
         layout = _loc6_;
         group = new LayoutGroup();
         group.layoutData = new AnchorLayoutData();
         (group.layoutData as AnchorLayoutData).top = 100;
         var _loc8_:HorizontalLayout = new HorizontalLayout();
         _loc8_.gap = 10;
         _loc8_.padding = 20;
         group.layout = _loc8_;
         addChild(group);
         var _loc1_:ButtonGroup = new ButtonGroup(mediator.mainMenu);
         _loc1_.buttonSignal.add(mainGroupListener);
         time = LabelStyle.label_size16_multiline();
         time.layoutData = new AnchorLayoutData();
         (time.layoutData as AnchorLayoutData).bottom = 25;
         (time.layoutData as AnchorLayoutData).left = 5;
         GameTimer.instance.oneSecTimer.add(updateClientTime);
         var _loc4_:PlayerStatsPanel = mediator.playerStatsPanelMediator.panel;
         _loc4_.layoutData = new AnchorLayoutData();
         (_loc4_.layoutData as AnchorLayoutData).top = 5;
         (_loc4_.layoutData as AnchorLayoutData).right = 0;
         addChild(_loc4_);
         addChild(mediator.playerStatsPanelMediator.portraitGroup);
         addChild(mediator.iconicMenuMediator.panel);
         var _loc7_:HomeScreenClanMenu = mediator.clanMenuMediator.panel;
         _loc7_.layoutData = new AnchorLayoutData();
         (_loc7_.layoutData as AnchorLayoutData).bottom = -2;
         (_loc7_.layoutData as AnchorLayoutData).left = 10;
         addChild(_loc7_);
         var _loc2_:SpecialOfferSideBar = mediator.specialOfferSideBar.panel;
         _loc2_.layoutData = new AnchorLayoutData();
         (_loc2_.layoutData as AnchorLayoutData).right = 10;
         (_loc2_.layoutData as AnchorLayoutData).verticalCenter = 0;
         addChild(_loc2_);
         var _loc3_:LayoutGroup = new LayoutGroup();
         _loc3_.layout = new HorizontalLayout();
         (_loc3_.layout as HorizontalLayout).gap = 5;
         _loc3_.layoutData = new AnchorLayoutData();
         (_loc3_.layoutData as AnchorLayoutData).bottom = 5;
         (_loc3_.layoutData as AnchorLayoutData).right = 5;
         addChild(_loc3_);
         fullScreenButtonOn = AssetStorage.rsx.popup_theme.button_fullscreen_on();
         TooltipHelper.addTooltip(fullScreenButtonOn.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_FULLSCREEN_ON")));
         fullScreenButtonOn.graphics.addEventListener("touch",onTouchFullScreenButton);
         _loc3_.addChild(fullScreenButtonOn.graphics);
         fullScreenButtonOff = AssetStorage.rsx.popup_theme.button_fullscreen_off();
         TooltipHelper.addTooltip(fullScreenButtonOff.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_FULLSCREEN_OFF")));
         fullScreenButtonOff.graphics.addEventListener("touch",onTouchFullScreenButton);
         _loc3_.addChild(fullScreenButtonOff.graphics);
         updateFullScreenButtons();
         var _loc5_:ClipButton = AssetStorage.rsx.popup_theme.button_settings();
         TooltipHelper.addTooltip(_loc5_.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_POPUP_SETTINGS_TITLE")));
         _loc3_.addChild(_loc5_.graphics);
         _loc5_.signal_click.add(mediator.action_settings);
         resize(width,height);
      }
      
      protected function resize(param1:int, param2:int) : void
      {
         mediator.playerStatsPanelMediator.portraitGroup.x = 5;
         mediator.playerStatsPanelMediator.portraitGroup.y = 5;
         mediator.iconicMenuMediator.panel.x = int(param1 * 0.5 - mediator.iconicMenuMediator.panel.width * 0.5);
         mediator.iconicMenuMediator.panel.y = int(param2 - mediator.iconicMenuMediator.panel.height);
      }
      
      private function onPlayerInit() : void
      {
      }
      
      private function updateFullScreenButtons() : void
      {
         fullScreenButtonOff.graphics.visible = mediator.fullScreenMode;
         fullScreenButtonOn.graphics.visible = !mediator.fullScreenMode;
      }
      
      private function handler_fullScreenStateChange() : void
      {
         updateFullScreenButtons();
      }
      
      private function onTouchFullScreenButton(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.phase == "began")
         {
            Starling.current.nativeStage.addEventListener("mouseUp",onStageMouseUp);
         }
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         Starling.current.nativeStage.removeEventListener("mouseUp",onStageMouseUp);
         mediator.changeFullScreenMode();
      }
      
      private function updateClientTime() : void
      {
         time.text = GameTimer.getPlayerTime(true);
      }
      
      private function consoleLog(... rest) : void
      {
         console.text = rest + "\n" + console.text;
      }
      
      private function mainGroupListener(param1:String) : void
      {
         this.dictKey = param1;
         if(subGroup)
         {
            group.removeChild(subGroup);
            subGroup.buttonSignal.clear();
            subGroup = null;
         }
         subGroup = new ButtonGroup(mediator.mainMenu[param1]);
         subGroup.buttonSignal.add(subListener);
         group.addChild(subGroup);
      }
      
      private function subListener(param1:String) : void
      {
         buttonSignal.dispatch(dictKey,param1);
      }
   }
}
