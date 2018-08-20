package game.mechanics.dungeon.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.DungeonFloorsAsset;
   import game.mechanics.dungeon.mediator.DungeonFloorGroupValueObject;
   import game.mechanics.dungeon.mediator.DungeonScreenMediator;
   import game.mechanics.dungeon.model.PlayerDungeonData;
   import game.mechanics.dungeon.popup.floor.DungeonFloorTeamRenderer;
   import game.mechanics.dungeon.popup.list.DungeonFloorGroupList;
   import game.mechanics.dungeon.popup.list.DungeonFloorGroupRenderer;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.model.user.tower.PlayerTowerData;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.animation.Juggler;
   import starling.events.Event;
   
   public class DungeonScreen extends ClipBasedPopup implements ITutorialNodePresenter
   {
      
      public static const INVALIDATION_FLAG_ELEMENTS_VISIBLE:String = "elements_visible";
      
      public static const WIDTH:int = 1000;
      
      public static const HEIGHT:int = 640;
       
      
      private var juggler:Juggler;
      
      private var mediator:DungeonScreenMediator;
      
      private var list:DungeonFloorGroupList;
      
      private var progressbar:ClipProgressBar;
      
      private var initializationDataReady:Boolean;
      
      private var initializationAssetReady:Boolean;
      
      private var assetProgress:AssetProgressProvider;
      
      private var heroes:DungeonFloorTeamRenderer;
      
      private var clip:DungeonScreenClip;
      
      private var parallaxLayerTest_back_width:Number;
      
      private var parallaxLayerTest_back:GuiAnimation;
      
      private var parallaxLayer_far_back:GuiAnimation;
      
      public function DungeonScreen(param1:DungeonScreenMediator)
      {
         juggler = new Juggler();
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         initializationDataReady = false;
         initializationAssetReady = false;
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         removeEventListener("enterFrame",handler_enterFrame);
         if(heroes)
         {
            heroes.dispose();
         }
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.CLAN_DUNGEON;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mediator.whenDataReady(handler_dataReady);
         if(AssetStorage.rsx.dungeon_floors.completed)
         {
            handler_assetLoaded(AssetStorage.rsx.dungeon_floors);
         }
         else
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.dungeon_floors,handler_assetLoaded);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(AssetStorage.rsx.dungeon_floors);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
         addEventListener("enterFrame",handler_enterFrame);
      }
      
      protected function tryInitialize() : void
      {
         if(initializationDataReady && initializationAssetReady)
         {
            _initialize();
            PlayerDungeonData.__print("screen","_initialize");
         }
      }
      
      protected function _initialize() : void
      {
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         clip = AssetStorage.rsx.dungeon_floors.create(DungeonScreenClip,"dungeon_view_main");
         mediator.property_currentQuest.signal_update.add(handler_questUpdate);
         handler_questUpdate();
         parallaxLayer_far_back = AssetStorage.rsx.dungeon_floors.create(GuiAnimation,"parallaxLayer_far_back");
         addChild(parallaxLayer_far_back.graphics);
         parallaxLayerTest_back = AssetStorage.rsx.dungeon_floors.create(GuiAnimation,"parallaxLayerTest_back");
         addChild(parallaxLayerTest_back.graphics);
         parallaxLayerTest_back_width = parallaxLayerTest_back.graphics.width;
         list = new DungeonFloorGroupList();
         list.width = 1000;
         height = 640;
         list.height = 640;
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.dataProvider = mediator.floorList;
         addChild(list);
         list.property_verticalScrollPosition.signal_update.add(handle_parallaxVertical);
         width = 1000;
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         clip.button_finish.signal_click.add(mediator.action_farmCurrentQuest);
         clip.tf_label_questReward.text = Translate.translate("UI_DIALOG_QUEST_REWARD");
         clip.button_finish.label = Translate.translate("UI_DIALOG_QUEST_FARM");
         clip.tf_titanite.text = Translate.translate("UI_DUNGEON_VIEW_MAIN_TF_TITANITE");
         clip.button_guide.label = Translate.translate("UI_TOWER_RULES");
         clip.button_titans.label = Translate.translate("UI_DIALOG_HERO_ELEMENT_NAVIGATE_TO_TITAN");
         clip.icon_new.graphics.touchable = false;
         clip.button_guide.signal_click.add(mediator.action_showGuide);
         clip.button_titans.signal_click.add(mediator.action_showTitans);
         mediator.property_dungeonActivityPoints.signal_update.add(handler_updateActivityValue);
         mediator.property_dungeonMaxActivityPoints.signal_update.add(handler_updateActivityValue);
         mediator.property_nextTitaniteReward.signal_update.add(handler_updateTitaniteReward);
         mediator.action_initUIValues();
         mediator.signal_currentQuestProgressUpdate.add(handler_questProgressUpdate);
         mediator.signal_floorUpdate.add(handler_floorUpdate);
         mediator.transitionController.initialize(list);
         DungeonFloorGroupValueObject.property_horizontalScrollPosition.signal_update.add(handler_parallaxHorizontal);
         mediator.property_titanWatcherIconState.signal_update.add(handler_updateRedIcon);
         handler_updateRedIcon(mediator.property_titanWatcherIconState.value);
         heroes = new DungeonFloorTeamRenderer(mediator.state,juggler);
         heroes.start();
         mediator.transitionController.addToJuggler(juggler);
      }
      
      private function handler_updateActivityValue(param1:int) : void
      {
         clip.tf_titanite_yours.text = Translate.translateArgs("UI_DUNGEON_VIEW_MAIN_TF_TITANITE_YOURS",mediator.property_playerDungeonActivityPoints.value);
         clip.progress_titanite.value = mediator.property_dungeonActivityPoints.value;
         clip.progress_titanite.maxValue = mediator.property_dungeonMaxActivityPoints.value;
      }
      
      private function handler_updateTitaniteReward(param1:InventoryItem) : void
      {
         clip.reward_item.graphics.visible = param1.amount > 0;
         if(param1.amount > 0)
         {
            clip.reward_item.setData(param1);
         }
      }
      
      private function handler_dataReady() : void
      {
         PlayerDungeonData.__print("screen","handler_dataReady");
         initializationDataReady = true;
         tryInitialize();
      }
      
      protected function handler_assetLoaded(param1:DungeonFloorsAsset) : void
      {
         PlayerTowerData.__print("screen","handler_assetLoaded");
         initializationAssetReady = true;
         tryInitialize();
      }
      
      private function handler_listRendererAdded(param1:Event, param2:DungeonFloorGroupRenderer) : void
      {
         param2.signal_select.add(mediator.action_selectFloor);
         param2.signal_saveProgress.add(mediator.action_initiateSaving);
         DungeonFloorGroupValueObject.action_registerList(param2.list);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:DungeonFloorGroupRenderer) : void
      {
         param2.signal_select.remove(mediator.action_selectFloor);
         param2.signal_saveProgress.remove(mediator.action_initiateSaving);
         DungeonFloorGroupValueObject.action_unregisterList(param2.list);
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_floorUpdate() : void
      {
         var _loc1_:String = Translate.translateArgs("UI_TOWER_FLOOR",mediator.currentFloor);
         _loc1_ = _loc1_.replace("{color}",ColorUtils.hexToRGBFormat(16645626));
         invalidate("elements_visible");
      }
      
      private function handler_parallaxHorizontal(param1:Number) : void
      {
         var _loc2_:Number = 5780;
         parallaxLayerTest_back.graphics.x = -(param1 / _loc2_) * (parallaxLayerTest_back_width - 1000);
      }
      
      private function handle_parallaxVertical(param1:int) : void
      {
         var _loc2_:int = 563;
         var _loc3_:int = param1 / 4;
         while(_loc3_ > _loc2_)
         {
            _loc3_ = _loc3_ - _loc2_;
         }
         _loc3_ = _loc3_ * -1;
         parallaxLayerTest_back.graphics.y = _loc3_;
      }
      
      private function handler_questUpdate(param1:Object = null) : void
      {
         var _loc2_:PlayerQuestValueObject = mediator.property_currentQuest.value as PlayerQuestValueObject;
         clip.layout_reward.visible = _loc2_;
         if(_loc2_)
         {
            clip.tf_quest.text = _loc2_.taskDescription + " (" + _loc2_.progressCurrent + "/" + _loc2_.progressMax + ")";
            clip.quest_reward.data = _loc2_.rewards[0];
            clip.button_finish.graphics.visible = _loc2_.canFarm;
         }
         else
         {
            clip.tf_quest.text = Translate.translate("UI_DUNGEON_VIEW_MAIN_TF_QUEST");
         }
      }
      
      private function handler_questProgressUpdate() : void
      {
         var _loc1_:PlayerQuestValueObject = mediator.property_currentQuest.value as PlayerQuestValueObject;
         if(_loc1_)
         {
            clip.tf_quest.text = _loc1_.taskDescription + " (" + _loc1_.progressCurrent + "/" + _loc1_.progressMax + ")";
            clip.button_finish.graphics.visible = _loc1_.canFarm;
         }
      }
      
      private function handler_updateRedIcon(param1:Boolean) : void
      {
         clip.icon_new.graphics.visible = param1;
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         juggler.advanceTime(Number(param1.data));
      }
   }
}
