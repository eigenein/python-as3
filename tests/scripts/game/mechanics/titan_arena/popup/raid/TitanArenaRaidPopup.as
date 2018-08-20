package game.mechanics.titan_arena.popup.raid
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.raid.TitanArenaRaidPopupMediator;
   import game.mechanics.titan_arena.model.TitanArenaRaidBattleItem;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.hero.TimerQueueDispenser;
   import starling.events.Event;
   
   public class TitanArenaRaidPopup extends ClipBasedPopup
   {
       
      
      private var clip:TitanArenaRaidClip;
      
      private var mediator:TitanArenaRaidPopupMediator;
      
      private var dispencer:TimerQueueDispenser;
      
      public function TitanArenaRaidPopup(param1:TitanArenaRaidPopupMediator)
      {
         dispencer = new TimerQueueDispenser(TitanArenaRaidBattleItem,500);
         this.mediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.battles.unsubscribe(handler_battles);
         mediator.invalidBattle.unsubscribe(handler_invalidBattle);
         mediator.isPending.unsubscribe(handler_isPending);
         dispencer.signal_onElement.remove(rewardDispencered);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = (AssetStorage.rsx.getByName("dialog_titan_arena") as RsxGuiAsset).create(TitanArenaRaidClip,"popup_titan_arena_raid");
         clip.list_battles.itemRendererType = TitanArenaRaidPopupBattleItemRenderer;
         clip.list_battles.dataProvider = new ListCollection();
         clip.list_battles.addEventListener("rendererAdd",handler_listRendererAdded);
         clip.list_battles.addEventListener("rendererRemove",handler_listRendererRemoved);
         var _loc1_:VerticalLayout = new VerticalLayout();
         var _loc2_:int = 10;
         _loc1_.paddingBottom = _loc2_;
         _loc1_.paddingTop = _loc2_;
         _loc1_.gap = 5;
         clip.list_battles.layout = _loc1_;
         clip.button_close.signal_click.add(mediator.close);
         clip.button_finish.initialize(Translate.translate("UI_COMMON_OK"),handler_finishButton);
         updateButton();
         clip.title = !!mediator.isFinalStage?Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_TITLE_FINAL"):Translate.translateArgs("UI_DIALOG_TITAN_ARENA_RAID_TITLE",mediator.stage);
         clip.tf_header_enemy.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_ENEMY");
         clip.tf_header_points.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_POINTS");
         clip.tf_header_reward.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_REWARD");
         clip.tf_invalidBattle.text = Translate.translate("UI_TITAN_ARENA_RAID_VALIDATION_ERROR");
         if(Translate.has("UI_TITAN_ARENA_RAID_IS_PENDING"))
         {
            clip.tf_wait.text = Translate.translate("UI_TITAN_ARENA_RAID_IS_PENDING");
         }
         else
         {
            clip.tf_wait.text = "...";
         }
         dispencer.signal_onElement.add(rewardDispencered);
         mediator.battles.onValue(handler_battles);
         mediator.invalidBattle.onValue(handler_invalidBattle);
         mediator.isPending.onValue(handler_isPending);
         addChild(clip.graphics);
         centerPopupBy(clip.bg.graphics);
      }
      
      private function handler_listRendererAdded(param1:Event, param2:TitanArenaRaidPopupBattleItemRenderer) : void
      {
         param2.signal_info.add(mediator.action_info);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:TitanArenaRaidPopupBattleItemRenderer) : void
      {
         param2.signal_info.remove(mediator.action_info);
      }
      
      private function handler_battles(param1:Vector.<TitanArenaRaidBattleItem>) : void
      {
         dispencer.add(param1);
         updateButton();
      }
      
      protected function updateButton() : void
      {
         if(dispencer.isEmpty)
         {
            clip.button_finish.label = Translate.translate("UI_COMMON_OK");
         }
         else
         {
            clip.button_finish.label = Translate.translate("UI_MULTIFARM_SHOW_ALL");
         }
      }
      
      protected function rewardDispencered(param1:TitanArenaRaidBattleItem) : void
      {
         clip.list_battles.dataProvider.addItem(param1);
         clip.list_battles.scrollToDisplayIndex(clip.list_battles.dataProvider.length - 1,0.25);
         if(dispencer.isEmpty)
         {
            showAll();
         }
      }
      
      protected function showAll() : void
      {
         dispencer.reset();
         var _loc2_:int = clip.list_battles.dataProvider.length;
         var _loc1_:Number = clip.list_battles.verticalScrollPosition;
         clip.list_battles.dataProvider = mediator.enemyList;
         clip.list_battles.verticalScrollPosition = _loc1_;
         if(mediator.enemyList.length != _loc2_)
         {
            clip.list_battles.scrollToDisplayIndex(clip.list_battles.dataProvider.length - 1,0.25 + (clip.list_battles.dataProvider.length - _loc2_ - 1) * 0.1);
         }
         dispencer.signal_onElement.remove(rewardDispencered);
         updateButton();
      }
      
      protected function handler_finishButton() : void
      {
         if(dispencer.isEmpty)
         {
            mediator.action_finish();
         }
         else
         {
            showAll();
         }
      }
      
      private function handler_invalidBattle(param1:Boolean) : void
      {
         clip.tf_invalidBattle.visible = param1;
      }
      
      private function handler_isPending(param1:Boolean) : void
      {
         clip.tf_wait.visible = param1;
         clip.button_finish.graphics.visible = !param1;
      }
   }
}
