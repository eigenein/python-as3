package game.view.popup.hero.upgrade
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.posting.ActionType;
   import engine.context.platform.social.posting.PostUtils;
   import engine.context.platform.social.posting.StoryPostParams;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.GameModel;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroColorUpPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var clip:HeroColorUpPopupClip;
      
      private var heroEntry:HeroEntry;
      
      private var portrait_before:HeroPortrait;
      
      private var portrait_after:HeroPortrait;
      
      private var prevPower:int;
      
      private var _canShare:Boolean;
      
      public function HeroColorUpPopup(param1:HeroEntry, param2:int)
      {
         _canShare = GameModel.instance.actionManager.platform.storyPostEnabled;
         super(null);
         this.prevPower = param2;
         this.heroEntry = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HERO_COLOR_UP;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_color_up();
         addChild(clip.graphics);
         clip.layout_fragment_btns.height = NaN;
         clip.tf_header.text = Translate.translate("UI_POPUP_HERO_PROMOTE_TITLE");
         clip.okButton.label = Translate.translate("UI_POPUP_HERO_UPGRADE_OK");
         var _loc3_:HeroEntrySourceData = new HeroEntrySourceData({
            "level":heroEntry.level.level,
            "star":heroEntry.star.star.id,
            "color":heroEntry.color.color.id - 1,
            "slots":[0,0,0,0,0,0,0]
         });
         var _loc2_:HeroEntry = new HeroEntry(heroEntry.hero,_loc3_);
         clip.tf_hero_name.text = heroEntry.name;
         portrait_before = new HeroPortrait();
         clip.hero_portrait_1.container.addChild(portrait_before);
         portrait_after = new HeroPortrait();
         clip.hero_portrait_2.container.addChild(portrait_after);
         portrait_after.data = new HeroEntryValueObject(heroEntry.hero,heroEntry);
         portrait_before.data = new HeroEntryValueObject(heroEntry.hero,_loc2_);
         var _loc1_:int = heroEntry.color.color.skillTierUnlock;
         if(_loc1_)
         {
            _loc4_ = DataStorage.skill.getByHeroAndTier(heroEntry.id,_loc1_);
            clip.tf_skill_name.text = Translate.translateArgs("UI_POPUP_HERO_UPGRADE_NEW_SKILL",_loc4_.name);
            clip.skillIcon.data = _loc4_;
         }
         else
         {
            clip.skillIcon.graphics.visible = false;
            clip.tf_skill_name.visible = false;
         }
         clip.stat_1.tf_stat_per_lvl.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
         clip.stat_1.tf_stat_scale_before.text = prevPower.toString();
         clip.stat_1.tf_stat_scale_after.text = heroEntry.getPower().toString();
         clip.layout_fragment_btns.validate();
         width = clip.ribbon_154_154_2_inst0.graphics.width;
         height = clip.layout_fragment_btns.y + clip.layout_fragment_btns.height;
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
         whenDisplayed(playSound);
      }
      
      private function share() : void
      {
         var _loc1_:StoryPostParams = PostUtils.fillHeroPostParams(heroEntry.hero,ActionType.PROMOTE,heroEntry.color.color.id);
         GameModel.instance.actionManager.platform.storyPost(_loc1_);
         close();
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.heroUp.play();
      }
   }
}
