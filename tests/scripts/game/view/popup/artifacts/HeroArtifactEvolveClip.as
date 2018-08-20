package game.view.popup.artifacts
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.artifacts.HeroArtifactsPopupMediator;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipList;
   
   public class HeroArtifactEvolveClip extends GuiClipNestedContainer
   {
       
      
      public var mediator:HeroArtifactsPopupMediator;
      
      public var title:HeroArtifactUpgradeTitleClip;
      
      public var tf_desc:ClipLabel;
      
      public var action_button:ClipButtonLabeled;
      
      public var content_container:ClipLayout;
      
      public var craft_recipe_list:ClipList;
      
      public var craft_recipe_item:ClipDataProvider;
      
      public function HeroArtifactEvolveClip()
      {
         title = new HeroArtifactUpgradeTitleClip();
         tf_desc = new ClipLabel();
         action_button = new ClipButtonLabeled();
         content_container = ClipLayout.verticalMiddleCenter(0,tf_desc);
         super();
         craft_recipe_list = new ClipList(ClipListItemArtifactCraftRecipe);
         craft_recipe_item = craft_recipe_list.itemClipProvider;
         craft_recipe_list.list = new List();
         craft_recipe_list.list.verticalScrollPolicy = "off";
         craft_recipe_list.list.layout = new HorizontalLayout();
         (craft_recipe_list.list.layout as HorizontalLayout).horizontalAlign = "center";
      }
      
      public function updateState() : void
      {
         if(mediator.artifactAwaked)
         {
            title.tf_title.text = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_ARTIFACT_EVOLUTION");
         }
         else
         {
            title.tf_title.text = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_ARTIFACT_AWAKENING");
         }
         tf_desc.graphics.visible = !mediator.artifactIsAvaliable || mediator.artifactMaxStars;
         if(!mediator.artifactIsAvaliable)
         {
            tf_desc.text = Translate.translateArgs("UI_DIALOG_HERO_ARTIFACTS_NOT_AVALIABLE",mediator.artifactMinHeroLevel);
         }
         else if(mediator.artifactMaxStars)
         {
            tf_desc.text = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_MAX_STARS");
         }
         craft_recipe_list.graphics.visible = mediator.artifactIsAvaliable && !mediator.artifactMaxStars;
         if(mediator.artifactIsAvaliable && !mediator.artifactMaxStars)
         {
            craft_recipe_list.list.dataProvider = new ListCollection(mediator.artifactNextStarRecipe);
         }
         action_button.graphics.visible = mediator.artifactIsAvaliable && !mediator.artifactMaxStars;
         if(mediator.artifactAwaked)
         {
            action_button.label = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_EVOLUTION");
         }
         else
         {
            action_button.label = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_AWAKENING");
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         action_button.signal_click.add(handler_actionButtonClick);
      }
      
      private function handler_actionButtonClick() : void
      {
         mediator.action_evolve();
      }
   }
}
