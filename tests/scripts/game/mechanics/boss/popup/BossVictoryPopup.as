package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.reward.RewardData;
   import game.mechanics.boss.model.BossBattleResultValueObject;
   import game.mediator.gui.component.RewardPopupStarAnimator;
   import game.mediator.gui.component.StarValueObject;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionFactory;
   import game.model.user.Player;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBar;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class BossVictoryPopup extends AsyncClipBasedPopup
   {
       
      
      private var result:BossBattleResultValueObject;
      
      private var clip:BossVictoryPopupClip;
      
      private var starDispenser:RewardPopupStarAnimator;
      
      private var sideBar:PopupSideBar;
      
      public const signal_closed:Signal = new Signal();
      
      public function BossVictoryPopup(param1:Player, param2:BossBattleResultValueObject)
      {
         super(null,AssetStorage.rsx.dialog_boss);
         this.result = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(starDispenser)
         {
            starDispenser.dispose();
         }
         if(sideBar)
         {
            sideBar.dispose();
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc3_:int = 0;
         clip = param1.create(BossVictoryPopupClip,"dialog_boss_victory");
         addChild(clip.graphics);
         width = clip.bounds_layout_container.graphics.width;
         height = clip.bounds_layout_container.graphics.height;
         clip.tf_label_header.text = Translate.translate("UI_DIALOG_ARENA_VICTORY");
         clip.tf_label_description.text = Translate.translateArgs("UI_DIALOG_BOSS_VICTORY_DESCRIPTION",result.bossLevel);
         clip.button_stats.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         clip.button_ok.label = Translate.translate("UI_DIALOG_BOSS_VICTORY_OPEN");
         clip.tf_reward.text = Translate.translate("UI_DIALOG_MISSION_VICTORY_REWARDS");
         var _loc6_:RewardData = new RewardData();
         _loc6_.add(result.everyWinReward);
         _loc6_.add(result.firstWinReward);
         _loc4_ = 0;
         while(_loc4_ < _loc6_.outputDisplay.length)
         {
            _loc7_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
            _loc7_.setData(_loc6_.outputDisplay[_loc4_]);
            clip.layout_rewards.addChild(_loc7_.container);
            _loc4_++;
         }
         clip.button_stats.graphics.visible = result.result.battleStatistics;
         clip.button_stats.signal_click.add(handler_showStats);
         clip.button_ok.signal_click.add(handler_close);
         starDispenser = new RewardPopupStarAnimator(400,result.stars);
         starDispenser.signal_onElement.add(handler_animateStar);
         var _loc2_:int = clip.star_animation.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.star_animation[_loc3_].graphics.visible = false;
            clip.star_animation[_loc3_].stop();
            _loc3_++;
         }
         starDispenser.start();
         whenDisplayed(playSound);
         var _loc5_:IPopupSideBarBlock = SocialGroupPromotionFactory.bossVictory();
         if(_loc5_)
         {
            sideBar = new PopupSideBar(this);
            sideBar.setBlock(_loc5_);
            addChild(sideBar.graphics);
         }
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.battleWin.play();
      }
      
      private function handler_animateStar(param1:StarValueObject) : void
      {
         var _loc2_:GuiAnimation = clip.star_animation[param1.star - 1] as GuiAnimation;
         if(_loc2_)
         {
            _loc2_.graphics.visible = true;
            _loc2_.playOnce();
         }
      }
      
      private function handler_showStats() : void
      {
         var _loc1_:BattleStatisticsPopup = new BattleStatisticsPopup(result.attackerTeamStats,result.defenderTeamStats);
         _loc1_.addEventListener("removed",handler_statisticsPopupRemoved);
         PopUpManager.addPopUp(_loc1_);
         Game.instance.screen.hideNotDisposedBattle();
      }
      
      private function handler_close() : void
      {
         close();
         signal_closed.dispatch();
      }
      
      private function handler_statisticsPopupRemoved(param1:Event) : void
      {
         Game.instance.screen.showNotDisposedBattle();
      }
   }
}
