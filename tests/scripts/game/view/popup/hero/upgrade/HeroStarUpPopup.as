package game.view.popup.hero.upgrade
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.posting.ActionType;
   import engine.context.platform.social.posting.PostUtils;
   import engine.context.platform.social.posting.StoryPostParams;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.GameModel;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroStarUpPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var heroEntry:HeroEntry;
      
      private var clip:HeroStarUpPopupClip;
      
      private var portrait_before:HeroPortrait;
      
      private var portrait_after:HeroPortrait;
      
      private var prevBattleStats:BattleStats;
      
      private var prevPower:int;
      
      private var _canShare:Boolean;
      
      public function HeroStarUpPopup(param1:HeroEntry, param2:BattleStats, param3:int)
      {
         _canShare = GameModel.instance.actionManager.platform.storyPostEnabled;
         super(null);
         this.prevPower = param3;
         this.prevBattleStats = param2;
         this.heroEntry = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HERO_STAR_UP;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_star_up();
         addChild(clip.graphics);
         width = clip.ribbon_154_154_2_inst0.graphics.width;
         height = clip.okButton.graphics.y + clip.okButton.graphics.height;
         clip.tf_header.text = Translate.translate("UI_POPUP_HERO_EVOLVE_TITLE");
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
         clip.tf_hero_name.text = heroEntry.name;
         portrait_before = new HeroPortrait();
         clip.hero_portrait_1.container.addChild(portrait_before);
         portrait_after = new HeroPortrait();
         clip.hero_portrait_2.container.addChild(portrait_after);
         var _loc5_:HeroEntrySourceData = new HeroEntrySourceData({
            "level":heroEntry.level.level,
            "star":heroEntry.star.star.id - 1,
            "color":heroEntry.color.color.id
         });
         var _loc1_:HeroEntry = new HeroEntry(heroEntry.hero,_loc5_);
         portrait_after.data = new HeroEntryValueObject(heroEntry.hero,heroEntry);
         portrait_before.data = new HeroEntryValueObject(heroEntry.hero,_loc1_);
         var _loc2_:BattleStats = _loc1_.star.statGrowthData.clone();
         var _loc4_:BattleStats = heroEntry.star.statGrowthData.clone();
         var _loc3_:BattleStats = heroEntry.getBasicBattleStats().clone();
         _loc3_.addMultiply(prevBattleStats,-1);
         clip.stat_1.tf_stat_per_lvl.text = Translate.translate("");
         clip.stat_1.tf_stat_scale_before.text = _loc1_.getPower().toString();
         clip.stat_1.tf_stat_scale_after.text = heroEntry.getPower().toString();
         setupStatScale(clip.stat_1,Translate.translate("LIB_BATTLESTATDATA_STRENGTH"),_loc2_.strength,_loc4_.strength,int(_loc3_.strength));
         setupStatScale(clip.stat_2,Translate.translate("LIB_BATTLESTATDATA_INTELLIGENCE"),_loc2_.intelligence,_loc4_.intelligence,int(_loc3_.intelligence));
         setupStatScale(clip.stat_3,Translate.translate("LIB_BATTLESTATDATA_AGILITY"),_loc2_.agility,_loc4_.agility,int(_loc3_.agility));
         setupStat(clip.stat_4,Translate.translate("UI_COMMON_HERO_POWER_COLON"),prevPower,heroEntry.getPower(),int(heroEntry.getPower() - prevPower));
         AssetStorage.sound.evolutionHero.play();
      }
      
      private function share() : void
      {
         var _loc1_:StoryPostParams = PostUtils.fillHeroPostParams(heroEntry.hero,ActionType.EVOLVE,portrait_after.data.starCount);
         GameModel.instance.actionManager.platform.storyPost(_loc1_);
         close();
      }
      
      private function setupStatScale(param1:UpgradeStatGroupClip, param2:String, param3:Number, param4:Number, param5:Number) : void
      {
         param1.tf_stat_per_lvl.text = Translate.translateArgs("UI_POPUP_HERO_UPGRADE_STAT_PER_LEVEL",param2);
         param1.tf_stat_scale_after.text = param4.toString();
         param1.tf_stat_scale_before.text = param3.toString();
         param1.tf_stat_total.text = "(" + Translate.translate(param2) + " +" + param5.toString() + ")";
      }
      
      private function setupStat(param1:UpgradeStatGroupClip, param2:String, param3:Number, param4:Number, param5:Number) : void
      {
         param1.tf_stat_per_lvl.text = Translate.translate(param2);
         param1.tf_stat_scale_after.text = param4.toString();
         param1.tf_stat_scale_before.text = param3.toString();
         param1.tf_stat_total.text = "(" + Translate.translate(param2) + " +" + param5.toString() + ")";
      }
   }
}
