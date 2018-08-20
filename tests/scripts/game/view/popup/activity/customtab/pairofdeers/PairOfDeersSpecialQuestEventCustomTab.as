package game.view.popup.activity.customtab.pairofdeers
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.battle.prefab.PairOfDeersPresentationBattle;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.billing.bundle.BundleSkillValueObject;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroEntrySourceData;
   import game.view.popup.activity.ISpecialQuestEventCustomTab;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class PairOfDeersSpecialQuestEventCustomTab implements ISpecialQuestEventCustomTab
   {
      
      public static const EVENT_ID:int = 21;
      
      public static const HERO1:int = 33;
      
      public static const HERO2:int = 34;
       
      
      private const _graphics:Sprite = new Sprite();
      
      private var clip:PairOfDeersSpecialQuestEventCustomTabClip;
      
      public function PairOfDeersSpecialQuestEventCustomTab()
      {
         clip = new PairOfDeersSpecialQuestEventCustomTabClip();
         super();
         var _loc1_:RsxGameAsset = AssetStorage.rsx.getByName("offer_specialEvent_pairOfDeers");
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc1_,handler_assetLoaded);
      }
      
      public function dispose() : void
      {
         _graphics.dispose();
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
      }
      
      public function get graphics() : DisplayObject
      {
         return _graphics;
      }
      
      public function get name() : String
      {
         return Translate.translate("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_TAB_NAME");
      }
      
      public function get sortOrder() : int
      {
         return 0;
      }
      
      protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         param1.initGuiClip(clip,"special_quest_event_tab");
         _graphics.addChild(clip.graphics);
         clip.button_replay.initialize(Translate.translate("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_DEMO_BATTLE"),handler_buttonReplay);
         clip.tf_text_1.text = Translate.translate("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_TEXT_1");
         clip.tf_text_2.text = Translate.translate("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_TEXT_2");
         clip.tf_text_3.text = Translate.translate("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_TEXT_3");
         var _loc2_:String = Translate.translateArgs("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_HERO_33_SKILLS_NAME",1);
         var _loc4_:String = Translate.translateArgs("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_HERO_34_SKILLS_NAME",1);
         var _loc3_:String = Translate.translateArgs("UI_DIALOG_SPECIAL_QUEST_PAIR_OF_DEERS_HERO_34_SKILLS_NAME",2);
         clip.tf_skills_1.text = _loc2_;
         clip.tf_skills_2.text = _loc3_;
         clip.container_hero_1.hero.playbackSpeed = 0.85;
         clip.container_hero_1.hero.loadHero(DataStorage.hero.getHeroById(33));
         clip.container_hero_2.hero.loadHero(DataStorage.hero.getHeroById(34));
         clip.skill_1.data = createSkill(34,3);
         clip.skill_2.data = createSkill(33,1);
         clip.skill_3.data = createSkill(34,1);
         clip.skill_1.tf_hero.text = _loc4_;
         clip.skill_2.tf_hero.text = _loc2_;
         clip.skill_3.tf_hero.text = _loc4_;
         clip.skill_4.data = createSkill(33,4);
         clip.skill_5.data = createSkill(34,2);
         clip.skill_6.data = createSkill(34,3);
      }
      
      private function createSkill(param1:int, param2:int) : BundleSkillValueObject
      {
         var _loc6_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc5_:SkillDescription = DataStorage.skill.getByHeroAndTier(param1,param2);
         var _loc3_:PlayerHeroEntry = new PlayerHeroEntry(_loc6_,PlayerHeroEntrySourceData.createEmpty(_loc6_));
         var _loc4_:SkillTooltipMessageFactory = new SkillTooltipMessageFactory(_loc3_,_loc5_);
         return new BundleSkillValueObject(_loc5_,_loc4_);
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         onAssetLoaded(param1);
      }
      
      private function handler_buttonReplay() : void
      {
         new PairOfDeersPresentationBattle().start();
      }
   }
}
