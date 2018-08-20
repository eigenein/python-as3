package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.boss.mediator.BossBrowsePopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class BossBrowsePopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:BossBrowsePopupMediator;
      
      private var clip:BossBrowsePopupClip;
      
      public function BossBrowsePopup(param1:BossBrowsePopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_boss);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(BossBrowsePopupClip,"dialog_browse_boss");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         clip.title = mediator.boss.type.name;
         clip.boss_renderer.mediator = new BossFrameRendererMediator(mediator.getPlayer(),mediator.boss.type);
         clip.boss_renderer.setData(mediator.boss.type);
         clip.every_win_reward_1.setData(mediator.bossChestInventoryItem);
         clip.every_win_reward_1.item_counter.graphics.visible = false;
         clip.every_win_reward_2.setData(mediator.attackBossLevel.everyWinReward.outputDisplay[0]);
         var _loc2_:Vector.<InventoryItem> = mediator.firstWinRewardList;
         clip.first_win_reward_1.setData(_loc2_[0]);
         clip.first_win_reward_2.setData(_loc2_[1]);
         clip.first_win_reward_3.setData(_loc2_[2]);
         clip.tf_reward_received.text = Translate.translate("UI_DIALOG_BOSS_BROWSE_RECEIVED_REWARD");
         clip.tf_reward_every_win.text = Translate.translate("UI_DIALOG_BOSS_BROWSE_EVERY_WIN_REWARD");
         clip.tf_reward_first_win.text = Translate.translate("UI_DIALOG_BOSS_BROWSE_FIRST_WIN_REWARD");
         if(mediator.boss.mayRaid.value)
         {
            clip.tf_attempts.text = Translate.translateArgs("UI_DIALOG_BOSS_ATTEMPTS",1);
            clip.action_btn.label = Translate.translate("UI_DIALOG_BOSS_RAID");
            clip.action_btn.signal_click.add(mediator.action_raid);
            clip.action_btn.graphics.y = 388;
         }
         else
         {
            clip.action_btn.label = Translate.translate("UI_DIALOG_BOSS_ATTACK");
            clip.action_btn.signal_click.add(mediator.action_attack);
            clip.action_btn.graphics.y = 377;
         }
         clip.bg_reward_received.graphics.visible = mediator.boss.mayRaid.value;
         clip.tf_reward_received.visible = mediator.boss.mayRaid.value;
      }
   }
}
