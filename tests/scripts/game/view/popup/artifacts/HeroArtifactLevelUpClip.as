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
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroArtifactLevelUpClip extends GuiClipNestedContainer
   {
       
      
      public var mediator:HeroArtifactsPopupMediator;
      
      public var title:HeroArtifactUpgradeTitleClip;
      
      public var tf_desc:ClipLabel;
      
      public var action_button:ClipButtonLabeled;
      
      public var content_container:ClipLayout;
      
      public var craft_recipe_list:ClipList;
      
      public var craft_recipe_item:ClipDataProvider;
      
      public function HeroArtifactLevelUpClip()
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
         title.graphics.visible = mediator.artifactAwaked;
         if(mediator.artifactIsAvaliable)
         {
            title.tf_title.text = ColorUtils.hexToRGBFormat(16568453) + Translate.translateArgs("UI_DIALOG_HERO_ARTIFACTS_LEVEL",ColorUtils.hexToRGBFormat(16645626) + mediator.artifact.level);
         }
         tf_desc.graphics.visible = !mediator.artifactAwaked || mediator.artifactMaxLevel;
         if(!mediator.artifactAwaked)
         {
            tf_desc.text = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_LEVEL_UP_DISABLED");
         }
         else if(mediator.artifactMaxLevel)
         {
            tf_desc.text = Translate.translate("UI_DIALOG_HERO_ARTIFACTS_MAX_LEVEL");
         }
         craft_recipe_list.graphics.visible = mediator.artifactAwaked && !mediator.artifactMaxLevel;
         if(mediator.artifactIsAvaliable && !mediator.artifactMaxLevel)
         {
            craft_recipe_list.list.dataProvider = new ListCollection(mediator.artifactNextLevelRecipe);
         }
         action_button.graphics.visible = mediator.artifactAwaked && !mediator.artifactMaxLevel;
         action_button.label = Translate.translateArgs("UI_DIALOG_HERO_ARTIFACTS_LEVEL_UP");
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         action_button.signal_click.add(handler_actionButtonClick);
      }
      
      private function handler_actionButtonClick() : void
      {
         mediator.action_level_up();
      }
   }
}
