package game.view.popup.fightresult.pve
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.component.StarValueObject;
   import game.mediator.gui.popup.tower.TowerRewardPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class TowerRewardPopup extends ClipBasedPopup
   {
       
      
      private var clip:TowerRewardPopupClip;
      
      private var mediator:TowerRewardPopupMediator;
      
      public function TowerRewardPopup(param1:TowerRewardPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(TowerRewardPopupClip,"dialog_victory_tower");
         addChild(clip.graphics);
         width = clip.bounds_layout_container.graphics.width;
         height = clip.bounds_layout_container.graphics.height;
         clip.tf_label_header.text = Translate.translate("UI_DIALOG_ARENA_VICTORY");
         clip.tf_reward_label.text = Translate.translate("UI_DIALOG_MISSION_VICTORY_REWARDS");
         clip.tf_label_bonus.text = Translate.translate("UI_DIALOG_TOWER_VICTORY_BONUS");
         clip.tf_label_points.text = Translate.translate("UI_DIALOG_TOWER_BATTLE_FLOOR_ENEMY_POINTS");
         clip.tf_label_total.text = Translate.translate("UI_DIALOG_TOWER_VICTORY_TOTAL");
         clip.button_stats_inst0.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         clip.okButton.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_OK");
         clip.okButton.signal_click.add(close);
         clip.button_stats_inst0.signal_click.add(mediator.action_showStats);
         clip.tf_points_base.text = mediator.reward_pointsBase.toString();
         clip.tf_points_total.text = mediator.reward_pointsTotal.toString();
         clip.tf_skulls_base.text = mediator.reward_skullsBase.toString();
         clip.tf_skulls_total.text = mediator.reward_skullsTotal.toString();
         var _loc3_:* = "x" + mediator.reward_starCount;
         clip.tf_star_count_1.text = _loc3_;
         clip.tf_star_count_2.text = _loc3_;
         var _loc1_:int = 3;
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            (clip["star_animation_" + _loc2_] as GuiAnimation).graphics.visible = false;
            (clip["star_animation_" + _loc2_] as GuiAnimation).stop();
            _loc2_++;
         }
         AssetStorage.sound.battleWin.play();
         mediator.signal_starAnimation.add(handler_animateStar);
         mediator.action_animateStars();
      }
      
      private function handler_animateStar(param1:StarValueObject) : void
      {
         var _loc2_:GuiAnimation = clip["star_animation_" + param1.star] as GuiAnimation;
         if(_loc2_)
         {
            _loc2_.graphics.visible = true;
            _loc2_.playOnce();
         }
      }
   }
}
