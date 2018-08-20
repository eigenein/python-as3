package game.mechanics.dungeon.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonBattleVictoryPopupMediator;
   import game.mechanics.dungeon.popup.reward.DungeonBattleVictoryPopupClip;
   import game.mediator.gui.component.StarValueObject;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.fightresult.pve.MissionRewardPopupRewardRenderer;
   import game.view.popup.fightresult.pve.RewardPopupHeroList;
   import game.view.popup.fightresult.pvp.ArenaVictoryPopupHeroItemRenderer;
   
   public class DungeonBattleVictoryPopup extends ClipBasedPopup
   {
       
      
      private var mediator:DungeonBattleVictoryPopupMediator;
      
      private var clip:DungeonBattleVictoryPopupClip;
      
      public function DungeonBattleVictoryPopup(param1:DungeonBattleVictoryPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc5_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.dungeon_floors.create(DungeonBattleVictoryPopupClip,"dialog_victory");
         addChild(clip.graphics);
         width = clip.bounds_layout_container.graphics.width;
         height = clip.bounds_layout_container.graphics.height;
         clip.tf_label_header.text = Translate.translate("UI_DIALOG_ARENA_VICTORY");
         if(mediator.rewardMultiplier > 1)
         {
            clip.tf_reward_label.text = Translate.translate("UI_DIALOG_DUNGEON_VICTORY_REWARDS_DOUBLE");
         }
         else
         {
            clip.tf_reward_label.text = Translate.translate("UI_DIALOG_MISSION_VICTORY_REWARDS");
         }
         clip.tf_reward_label.validate();
         clip.button_stats_inst0.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_STATS");
         clip.okButton.label = Translate.translate("UI_DIALOG_ARENA_VICTORY_OK");
         clip.okButton.signal_click.add(close);
         clip.button_stats_inst0.signal_click.add(mediator.action_showStats);
         _loc2_ = 3;
         _loc3_ = 1;
         while(_loc3_ <= 3)
         {
            (clip["star_animation_" + _loc3_] as GuiAnimation).graphics.visible = false;
            (clip["star_animation_" + _loc3_] as GuiAnimation).stop();
            _loc3_++;
         }
         var _loc6_:RewardPopupHeroList = new RewardPopupHeroList(ArenaVictoryPopupHeroItemRenderer);
         _loc6_.width = clip.hero_list_layout_container.width;
         _loc6_.height = clip.hero_list_layout_container.height;
         clip.hero_list_layout_container.addChild(_loc6_);
         _loc6_.dataProvider = new ListCollection(mediator.result.result.attackers);
         _loc2_ = mediator.itemRewardList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = new MissionRewardPopupRewardRenderer();
            clip.layout_item_list.addChild(_loc1_);
            _loc1_.data = mediator.itemRewardList[_loc4_];
            if(mediator.rewardMultiplier > 1)
            {
               _loc5_ = AssetStorage.rsx.dungeon_floors.create(ClipSprite,"icon_х2_large");
               var _loc7_:* = 0.85;
               _loc5_.graphics.scaleY = _loc7_;
               _loc5_.graphics.scaleX = _loc7_;
               _loc5_.graphics.x = 84 - _loc5_.graphics.width + 4;
               _loc5_.graphics.y = -4;
               _loc1_.addChild(_loc5_.graphics);
            }
            _loc4_++;
         }
         whenDisplayed(handler_whenDisplayed);
         mediator.signal_starAnimation.add(handler_animateStar);
         clip.layout_reward_label.addChild(clip.layout_item_list);
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
      
      private function handler_whenDisplayed() : void
      {
         AssetStorage.sound.battleWin.play();
         mediator.action_animateStars();
      }
   }
}
