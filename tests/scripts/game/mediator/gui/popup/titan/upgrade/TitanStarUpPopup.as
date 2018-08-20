package game.mediator.gui.popup.titan.upgrade
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.posting.ActionType;
   import engine.context.platform.social.posting.PostUtils;
   import engine.context.platform.social.posting.StoryPostParams;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.GameModel;
   import game.model.user.hero.TitanEntry;
   import game.model.user.hero.TitanEntrySourceData;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.hero.upgrade.HeroStarUpPopupClip;
   import game.view.popup.hero.upgrade.UpgradeStatGroupClip;
   
   public class TitanStarUpPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var titanEntry:TitanEntry;
      
      private var clip:HeroStarUpPopupClip;
      
      private var portrait_before:HeroPortrait;
      
      private var portrait_after:HeroPortrait;
      
      private var prevBattleStats:BattleStats;
      
      private var prevPower:int;
      
      private var _canShare:Boolean;
      
      public function TitanStarUpPopup(param1:TitanEntry, param2:BattleStats, param3:int)
      {
         _canShare = GameModel.instance.actionManager.platform.storyPostEnabled;
         super(null);
         this.prevPower = param3;
         this.prevBattleStats = param2;
         this.titanEntry = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HERO_STAR_UP;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_titan_star_up();
         addChild(clip.graphics);
         width = clip.ribbon_154_154_2_inst0.graphics.width;
         height = clip.okButton.graphics.y + clip.okButton.graphics.height;
         clip.tf_header.text = Translate.translate("UI_POPUP_TITAN_EVOLVE_TITLE");
         if(!_canShare)
         {
            clip.okButton.signal_click.add(close);
            clip.okButton.label = Translate.translate("UI_POPUP_HERO_UPGRADE_OK");
            clip.button_close.graphics.visible = false;
         }
         else
         {
            clip.okButton.label = Translate.translate("UI_DIALOG_REWARD_HERO_SHARE");
            clip.okButton.signal_click.add(share);
            clip.button_close.signal_click.add(close);
         }
         clip.tf_hero_name.text = titanEntry.name;
         portrait_before = new HeroPortrait();
         clip.hero_portrait_1.container.addChild(portrait_before);
         portrait_after = new HeroPortrait();
         clip.hero_portrait_2.container.addChild(portrait_after);
         var _loc4_:TitanEntrySourceData = new TitanEntrySourceData();
         _loc4_.level = titanEntry.level.level;
         _loc4_.star = titanEntry.star.star.id - 1;
         var _loc1_:TitanEntry = new TitanEntry(titanEntry.titan,_loc4_);
         portrait_after.data = new TitanEntryValueObject(titanEntry.titan,titanEntry);
         portrait_before.data = new TitanEntryValueObject(titanEntry.titan,_loc1_);
         var _loc2_:BattleStats = _loc1_.battleStats;
         var _loc3_:BattleStats = titanEntry.battleStats;
         clip.stat_1.tf_stat_per_lvl.text = Translate.translate("");
         clip.stat_1.tf_stat_scale_before.text = _loc1_.getPower().toString();
         clip.stat_1.tf_stat_scale_after.text = titanEntry.getPower().toString();
         setupStat(clip.stat_1,Translate.translate("LIB_BATTLESTATDATA_ATTACK") + ":",_loc2_.physicalAttack,_loc3_.physicalAttack,_loc3_.physicalAttack - _loc2_.physicalAttack);
         setupStat(clip.stat_2,Translate.translate("LIB_BATTLESTATDATA_HP") + ":",_loc2_.hp,_loc3_.hp,_loc3_.hp - _loc2_.hp);
         setupStat(clip.stat_3,Translate.translate("UI_COMMON_HERO_POWER_COLON"),prevPower,titanEntry.getPower(),titanEntry.getPower() - prevPower);
         AssetStorage.sound.evolutionHero.play();
      }
      
      private function share() : void
      {
         var _loc1_:StoryPostParams = PostUtils.fillTitanPostParams(titanEntry.titan,ActionType.EVOLVE,portrait_after.data.starCount);
         GameModel.instance.actionManager.platform.storyPost(_loc1_);
         close();
      }
      
      private function setupStatScale(param1:UpgradeStatGroupClip, param2:String, param3:Number, param4:Number, param5:Number) : void
      {
         param1.tf_stat_per_lvl.text = Translate.translateArgs("UI_POPUP_HERO_UPGRADE_STAT_PER_LEVEL",param2);
         param1.tf_stat_scale_after.text = Math.round(param4).toString();
         param1.tf_stat_scale_before.text = Math.round(param3).toString();
         param1.tf_stat_total.text = "(" + Translate.translate(param2) + " +" + Math.round(param5).toString() + ")";
      }
      
      private function setupStat(param1:UpgradeStatGroupClip, param2:String, param3:Number, param4:Number, param5:Number) : void
      {
         param1.tf_stat_per_lvl.text = Translate.translate(param2);
         param1.tf_stat_scale_after.text = Math.round(param4).toString();
         param1.tf_stat_scale_before.text = Math.round(param3).toString();
         param1.tf_stat_total.text = "(" + Translate.translate(param2) + " +" + Math.round(param5).toString() + ")";
      }
   }
}
