package game.view.popup.tower.screen
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.tower.TowerScreenMediator;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.tower.PlayerTowerData;
   import game.view.gui.homescreen.ShopHoverSound;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.IEscClosable;
   import game.view.popup.friends.socialquest.RewardItemClip;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.events.Event;
   
   public class TowerScreen extends AsyncClipBasedPopupWithPreloader implements IEscClosable
   {
      
      public static const INVALIDATION_FLAG_ELEMENTS_VISIBLE:String = "elements_visible";
      
      private static var _music:ShopHoverSound;
       
      
      private var initializationDataReady:Boolean;
      
      private var initializationAssetReady:Boolean;
      
      private var mediator:TowerScreenMediator;
      
      private var clip:TowerScreenClip;
      
      private var list:TowerScreenFloorList;
      
      private var timeout:Timer;
      
      public function TowerScreen(param1:TowerScreenMediator)
      {
         timeout = new Timer(50,1);
         super(param1,AssetStorage.rsx.tower_floors);
         this.mediator = param1;
      }
      
      public static function get music() : ShopHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(0.5,1.5,AssetStorage.sound.towerHover);
         }
         return _music;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(mediator.signal_pointsUpdate)
         {
            mediator.signal_pointsUpdate.remove(handler_pointsUpdate);
         }
         mediator.signal_buffsUpdate.remove(handler_buffsUpdate);
         mediator.signal_floorUpdate.remove(handler_floorUpdate);
         mediator.signal_updateCanProceed.remove(handler_updateCanProceed);
         if(clip)
         {
            clip.dispose();
         }
         else
         {
            initializationAssetReady = false;
         }
         timeout.stop();
      }
      
      public function getCurrentFloor() : int
      {
         if(list.lastIndex == -1)
         {
            return -1;
         }
         return mediator.floorList[list.lastIndex].number;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc3_:* = false;
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid("elements_visible") && clip)
         {
            _loc1_ = mediator.towerComplete && mediator.currentFloorChestsOpened > 0;
            clip.complete_panel.container.visible = _loc1_;
            updateCompletePanelState();
            _loc3_ = mediator.buffList.length > 0;
            clip.tf_label_buffs.container.visible = !_loc1_ && _loc3_;
            clip.bg_buffs.graphics.visible = !_loc1_ && _loc3_;
            clip.layout_buff_list.visible = !_loc1_ && _loc3_;
            if(_loc1_)
            {
               clip.complete_panel.reward_list_container.removeChildren(0,-1,true);
               _loc5_ = mediator.rewardsList;
               _loc2_ = 0;
               while(_loc2_ < _loc5_.length)
               {
                  _loc4_ = AssetStorage.rsx.popup_theme.create(RewardItemClip,"inventory_tile");
                  _loc4_.data = _loc5_[_loc2_];
                  clip.complete_panel.reward_list_container.addChild(_loc4_.container);
                  if(clip.complete_panel.reward_list_container.numChildren < 4)
                  {
                     _loc2_++;
                     continue;
                  }
                  break;
               }
            }
         }
      }
      
      private function updateCompletePanelState() : void
      {
         var _loc2_:Boolean = mediator.mayFullSkip;
         var _loc1_:Boolean = mediator.chestSkip;
         if(!_loc2_)
         {
            clip.complete_panel.playback.gotoAndStop(0);
            clip.complete_panel.tf_message_canFullSkipTomorrow.visible = false;
         }
         else
         {
            clip.complete_panel.tf_message.visible = false;
            clip.complete_panel.tf_skip_tower_desc.visible = false;
            if(_loc1_)
            {
               clip.complete_panel.playback.gotoAndStop(1);
            }
            else
            {
               clip.complete_panel.playback.gotoAndStop(1);
            }
         }
         clip.complete_panel.tf_message.text = Translate.translateArgs("UI_DIALOG_TOWER_COMPLETE_MESSAGE",ColorUtils.hexToRGBFormat(16645626) + "1-" + mediator.maxCountBattleFloorsTill);
         clip.complete_panel.tf_message_canFullSkipTomorrow.text = Translate.translate("UI_POPUP_TOWER_COMPLETE_TF_MESSAGE_CANFULLSKIPTOMORROW");
         clip.complete_panel.tf_skip_tower_desc.text = Translate.translate("UI_POPUP_TOWER_COMPLETE_TF_SKIP_TOWER_DESC");
         clip.complete_panel.tf_header.text = Translate.translate("UI_DIALOG_TOWER_COMPLETE_TITLE");
         clip.complete_panel.tf_reward_title.text = Translate.translate("UI_DIALOG_TOWER_COMPLETE_REWARD_TITLE");
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mediator.whenDataReady(handler_dataReady);
      }
      
      protected function tryInitialize() : void
      {
         if(initializationDataReady && initializationAssetReady)
         {
            _initialize();
            PlayerTowerData.__print("screen","_initialize");
         }
      }
      
      protected function _initialize() : void
      {
         clip = AssetStorage.rsx.tower_floors.create(TowerScreenClip,"tower_view_main");
         list = new TowerScreenFloorList();
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.useVirtualLayout = true;
         _loc1_.paddingBottom = -225;
         _loc1_.paddingTop = 150;
         list.layout = _loc1_;
         list.itemRendererType = TowerScreenFloorListItemRenderer;
         list.verticalMouseWheelScrollStep = 100;
         var _loc2_:String = "off";
         list.horizontalScrollPolicy = _loc2_;
         list.verticalScrollPolicy = _loc2_;
         list.throwEase = "easeInOut";
         list.hasElasticEdges = false;
         list.interactionMode = "mouse";
         addChild(list);
         width = 1000;
         list.width = 1000;
         height = 640;
         list.height = 640;
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.dataProvider = new ListCollection(mediator.floorList);
         list.scrollToDisplayIndex(0);
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_shop.label = Translate.translate("UI_TOWER_SHOP");
         clip.button_shop.signal_click.add(mediator.action_shop);
         clip.button_rules.label = Translate.translate("UI_TOWER_RULES");
         clip.button_rules.signal_click.add(mediator.action_rules);
         clip.tf_label_points.text = Translate.translate("UI_TOWER_POINTS");
         handler_pointsUpdate(0);
         mediator.signal_pointsUpdate.add(handler_pointsUpdate);
         mediator.signal_buffsUpdate.add(handler_buffsUpdate);
         mediator.signal_floorUpdate.add(handler_floorUpdate);
         mediator.signal_updateCanProceed.add(handler_updateCanProceed);
         handler_floorUpdate();
         handler_updateCanProceed();
         clip.layout_resource_list.addChild(mediator.resourcePanel.panel);
         clip.tf_label_buffs.text = Translate.translate("UI_TOWER_BUFFS");
         clip.setBuffList(mediator.buffList);
         timeout.addEventListener("timerComplete",handler_initFirstAnimation);
         timeout.start();
         list.scrollToDisplayIndex(mediator.currentFloorIndex);
         updateCompletePanelState();
         clip.complete_panel.button_browes.signal_click.add(mediator.showTowerRewards);
      }
      
      private function handler_pointsUpdate(param1:int) : void
      {
         clip.tf_points.text = mediator.points.toString();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         PlayerTowerData.__print("screen","handler_assetLoaded");
         initializationAssetReady = true;
         tryInitialize();
      }
      
      private function handler_listRendererAdded(param1:Event, param2:TowerScreenFloorListItemRenderer) : void
      {
         param2.signal_select.add(mediator.action_selectFloor);
         param2.signal_nextFloor.add(mediator.action_nextFloor);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:TowerScreenFloorListItemRenderer) : void
      {
         param2.signal_select.remove(mediator.action_selectFloor);
         param2.signal_nextFloor.remove(mediator.action_nextFloor);
      }
      
      private function handler_buffsUpdate() : void
      {
         clip.setBuffList(mediator.buffList);
         invalidate("elements_visible");
      }
      
      protected function handler_initFirstAnimation(param1:TimerEvent) : void
      {
         mediator.transitionController.initialize(list);
      }
      
      private function handler_floorUpdate() : void
      {
         var _loc1_:String = Translate.translateArgs("UI_TOWER_FLOOR",mediator.currentFloor);
         _loc1_ = _loc1_.replace("{color}",ColorUtils.hexToRGBFormat(16645626));
         clip.floor_view.tf_floor.text = _loc1_;
         invalidate("elements_visible");
      }
      
      private function handler_updateCanProceed() : void
      {
         invalidate("elements_visible");
      }
      
      private function handler_dataReady() : void
      {
         PlayerTowerData.__print("screen","handler_dataReady");
         initializationDataReady = true;
         tryInitialize();
      }
   }
}
