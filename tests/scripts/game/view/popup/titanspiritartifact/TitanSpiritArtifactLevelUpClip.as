package game.view.popup.titanspiritartifact
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.titanspiritartifact.TitanSpiritArtifactPopupMediator;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.artifacts.HeroArtifactUpgradeTitleClip;
   import game.view.popup.quest.QuestRewardItemRenderer;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TitanSpiritArtifactLevelUpClip extends GuiClipNestedContainer
   {
       
      
      public var mediator:TitanSpiritArtifactPopupMediator;
      
      public var title:HeroArtifactUpgradeTitleClip;
      
      public var tf_label_level_up_1:ClipLabel;
      
      public var tf_label_level_up_2:ClipLabel;
      
      public var button_level_up_1:ClipButtonLabeled;
      
      public var button_level_up_2:ClipButtonLabeled;
      
      public var price_1:QuestRewardItemRenderer;
      
      public var price_2:QuestRewardItemRenderer;
      
      public var layout_consumable_cost:ClipLayout;
      
      public var layout_star_money_cost:ClipLayout;
      
      public var line2:ClipSprite;
      
      public var content_container:ClipLayout;
      
      public var tf_desc:ClipLabel;
      
      public var desc_container:ClipLayout;
      
      public function TitanSpiritArtifactLevelUpClip()
      {
         title = new HeroArtifactUpgradeTitleClip();
         tf_label_level_up_1 = new ClipLabel();
         tf_label_level_up_2 = new ClipLabel();
         button_level_up_1 = new ClipButtonLabeled();
         button_level_up_2 = new ClipButtonLabeled();
         price_1 = new QuestRewardItemRenderer();
         price_2 = new QuestRewardItemRenderer();
         layout_consumable_cost = ClipLayout.horizontalMiddleCentered(10,price_1,button_level_up_1);
         layout_star_money_cost = ClipLayout.horizontalMiddleCentered(10,price_2,button_level_up_2);
         line2 = new ClipSprite();
         content_container = ClipLayout.none(tf_label_level_up_1,tf_label_level_up_2,layout_consumable_cost,layout_star_money_cost,line2);
         tf_desc = new ClipLabel();
         desc_container = ClipLayout.verticalMiddleCenter(0,tf_desc);
         super();
      }
      
      public function updateState() : void
      {
         title.graphics.visible = mediator.artifactAwaked;
         if(mediator.artifactIsAvaliable)
         {
            title.tf_title.text = ColorUtils.hexToRGBFormat(16568453) + Translate.translateArgs("UI_DIALOG_TITAN_SPIRIT_ARTIFACT_LEVEL",ColorUtils.hexToRGBFormat(16645626) + mediator.selectedArtifact.level);
         }
         desc_container.visible = !mediator.artifactAwaked || mediator.artifactMaxLevel;
         if(!mediator.artifactAwaked)
         {
            tf_desc.text = Translate.translate("UI_DIALOG_TITAN_SPIRIT_ARTIFACT_LEVEL_UP_DISABLED");
         }
         else if(mediator.artifactMaxLevel)
         {
            tf_desc.text = Translate.translate("UI_DIALOG_TITAN_SPIRIT_ARTIFACT_MAX_LEVEL");
         }
         content_container.visible = mediator.artifactAwaked && !mediator.artifactMaxLevel;
         if(content_container.visible)
         {
            price_1.data = mediator.artifactNextLevelCost.outputDisplayFirst;
            price_2.data = mediator.artifactNextLevelCostStarmoney.outputDisplayFirst;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_level_up_1.label = Translate.translate("UI_DIALOG_TITAN_ARTIFACTS_LEVEL_UP_ACTION");
         button_level_up_2.label = Translate.translate("UI_DIALOG_TITAN_ARTIFACTS_LEVEL_UP_ACTION");
         tf_label_level_up_1.text = Translate.translate("UI_DIALOG_TITAN_SPIRIT_ARTIFACTS_LEVEL_UP_CONSUMABLE_DESC");
         tf_label_level_up_2.text = Translate.translate("UI_DIALOG_TITAN_ARTIFACTS_LEVEL_UP_MONEY_DESC");
         button_level_up_1.signal_click.add(handler_buttonLevelUp1Click);
         button_level_up_2.signal_click.add(handler_buttonLevelUp2Click);
      }
      
      private function handler_buttonLevelUp1Click() : void
      {
         mediator.action_level_up();
      }
      
      private function handler_buttonLevelUp2Click() : void
      {
         mediator.action_level_up_starmoney();
      }
   }
}
