package game.mediator.gui.popup.titan.evolve
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.HeroPortrait;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanEvolveCostPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanEvolveCostPopupMediator;
      
      private var clip:TitanEvolveCostPopupClip;
      
      private var portrait:HeroPortrait;
      
      public function TitanEvolveCostPopup(param1:TitanEvolveCostPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(TitanEvolveCostPopupClip,"popup_hero_evolve");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         clip.button_ok.signal_click.add(mediator.action_evolve);
         clip.cost_panel.costData = mediator.evolveCost;
         if(mediator.isSummon)
         {
            clip.tf_label_header.text = Translate.translate("UI_POPUP_TITAN_EVOLVE_SUMMON");
            clip.button_ok.label = Translate.translate("UI_DIALOG_HERO_LIST_SUMMON");
         }
         else
         {
            clip.tf_label_header.text = Translate.translate("UI_POPUP_TITAN_EVOLVE_EVOLVE");
            clip.button_ok.label = Translate.translate("UI_DIALOG_HERO_LIST_EVOLVE");
         }
         clip.tf_hero_name.text = mediator.name;
         portrait = new HeroPortrait();
         clip.hero_portrait.container.addChild(portrait);
         portrait.data = mediator.entryValueObject;
      }
   }
}
