package game.view.popup.hero.evolve
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.evolve.HeroEvolveCostPopupMediator;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroEvolveCostPopup extends ClipBasedPopup implements ITutorialNodePresenter, ITutorialActionProvider
   {
       
      
      private var mediator:HeroEvolveCostPopupMediator;
      
      private var portrait:HeroPortrait;
      
      private var clip:HeroEvolveCostPopupClip;
      
      public function HeroEvolveCostPopup(param1:HeroEvolveCostPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.EVOLVE_HERO_CONFIRM;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButton(TutorialNavigator.ACTION_EVOLVE_HERO,clip.button_ok);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(HeroEvolveCostPopupClip,"popup_hero_evolve");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         clip.button_ok.signal_click.add(mediator.action_evolve);
         clip.cost_panel.costData = mediator.evolveCost;
         if(mediator.isSummon)
         {
            clip.tf_label_header.text = Translate.translate("UI_POPUP_HERO_EVOLVE_SUMMON");
            clip.button_ok.label = Translate.translate("UI_DIALOG_HERO_LIST_SUMMON");
         }
         else
         {
            clip.tf_label_header.text = Translate.translate("UI_POPUP_HERO_EVOLVE_EVOLVE");
            clip.button_ok.label = Translate.translate("UI_DIALOG_HERO_LIST_EVOLVE");
         }
         clip.tf_hero_name.text = mediator.name;
         portrait = new HeroPortrait();
         clip.hero_portrait.container.addChild(portrait);
         portrait.data = mediator.entryValueObject;
      }
   }
}
