package game.view.popup.activity
{
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.IEscClosable;
   import starling.events.Event;
   
   public class SpecialQuestEventPopup extends AsyncClipBasedPopupWithPreloader implements IEscClosable
   {
       
      
      private var mediator:SpecialQuestEventPopupMediator;
      
      private var clip:SpecialQuestEventPopupClip;
      
      private var dailyBonusView:DailyBonusView;
      
      private var skinShopView:SkinShopView;
      
      private var chainEventsView:ChainEventQuestsView;
      
      private var dropLayer:SpecialQuestEventDropLayer;
      
      private var _progressAsset:RequestableAsset;
      
      public function SpecialQuestEventPopup(param1:SpecialQuestEventPopupMediator)
      {
         dropLayer = new SpecialQuestEventDropLayer();
         super(param1,AssetStorage.rsx.event_icons);
         this.mediator = param1;
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.event_icons);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(clip)
         {
            clip.bg_image.dispose();
         }
         if(dailyBonusView && dailyBonusView.parent == null)
         {
            dailyBonusView.dispose();
         }
         if(chainEventsView && chainEventsView.parent == null)
         {
            chainEventsView.dispose();
         }
         mediator.signal_someRedMarkerUpdate.remove(signal_someRedMarkerUpdate);
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = AssetStorage.rsx.popup_theme.create_dialog_activity();
         addChild(clip.graphics);
         mediator.signal_someRedMarkerUpdate.add(signal_someRedMarkerUpdate);
         height = 500;
         clip.button_close.signal_click.add(mediator.close);
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.gap = -10;
         var _loc2_:int = 112 + _loc3_.gap;
         _loc3_.paddingTop = 5;
         _loc3_.paddingBottom = clip.event_list.height % _loc2_ + _loc3_.gap - _loc3_.paddingTop;
         clip.event_list.snapScrollPositionsToPixels = true;
         clip.event_list.snapToPages = true;
         clip.event_list.verticalMouseWheelScrollStep = _loc2_;
         clip.event_list.pageHeight = _loc2_;
         clip.event_list.layout = _loc3_;
         clip.event_list.scrollBarDisplayMode = "float";
         clip.event_list.revealScrollBarsDuration = 2;
         clip.event_list.hideScrollBarAnimationDuration = 1;
         clip.event_list.itemRendererType = QuestEventListItemRenderer;
         clip.event_list.addEventListener("rendererAdd",onListRendererAdded);
         clip.event_list.addEventListener("rendererRemove",onListRendererRemoved);
         clip.event_list.addEventListener("change",onEventListChange);
         clip.event_list.dataProvider = mediator.eventList;
         clip.event_list.selectedIndex = mediator.firstEventIndex;
         addChild(dropLayer.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      private function updateContentByEvent(param1:QuestEventValueObjectBase) : void
      {
         clip.content_container.container.removeChildren();
         clip.bg_image.dispose();
         if(param1 is QuestEventDailyBonusValueObject)
         {
            if(!dailyBonusView)
            {
               dailyBonusView = new DailyBonusView((param1 as QuestEventDailyBonusValueObject).dailyBonus,stashParams);
               dailyBonusView.x = 60;
               dailyBonusView.y = 30;
            }
            if(clip)
            {
               clip.content_container.container.addChild(dailyBonusView);
            }
         }
         else if(param1 is QuestEventSkinShopValueObject)
         {
            mediator.action_check_and_farm_daily_reward_skin_coins(param1 as QuestEventSkinShopValueObject);
            if(!skinShopView)
            {
               skinShopView = new SkinShopView((param1 as QuestEventSkinShopValueObject).mediator,stashParams);
               skinShopView.x = -10;
               skinShopView.y = -40;
            }
            if(clip)
            {
               clip.content_container.container.addChild(skinShopView);
            }
         }
         else
         {
            if(!chainEventsView)
            {
               chainEventsView = new ChainEventQuestsView(mediator,dropLayer);
               chainEventsView.x = 110;
               chainEventsView.y = 20;
            }
            chainEventsView.event = param1 as QuestEventSpecialValueObject;
            if(clip)
            {
               clip.content_container.container.addChild(chainEventsView);
            }
         }
         if(clip)
         {
            clip.tf_header.text = param1.name;
            clip.bg_image.load(param1.backgroundAsset);
         }
      }
      
      private function onListRendererAdded(param1:Event, param2:QuestEventListItemRenderer) : void
      {
         param2.signal_select.add(handler_selectEvent);
      }
      
      private function onListRendererRemoved(param1:Event, param2:QuestEventListItemRenderer) : void
      {
         param2.signal_select.remove(handler_selectEvent);
      }
      
      private function onEventListChange(param1:Event) : void
      {
         if(clip.event_list.selectedIndex == -1 && clip.event_list.dataProvider.length > 0)
         {
            clip.event_list.selectedIndex = 0;
         }
      }
      
      private function handler_selectEvent(param1:QuestEventValueObjectBase) : void
      {
         updateContentByEvent(param1);
      }
      
      private function signal_someRedMarkerUpdate() : void
      {
         clip.event_list.updateMarkersIndices();
      }
   }
}
