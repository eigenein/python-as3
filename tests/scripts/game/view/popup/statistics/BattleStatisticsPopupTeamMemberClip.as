package game.view.popup.statistics
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.battle.controller.statistic.BattleDamageStatisticsValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.hero.MiniHeroPortraitClip;
   
   public class BattleStatisticsPopupTeamMemberClip extends GuiClipNestedContainer
   {
       
      
      private var mirrored:Boolean;
      
      public var tf_label_dmg:ClipLabel;
      
      public var tf_dmg:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_name:ClipLabel;
      
      public var hero:MiniHeroPortraitClip;
      
      public var progressbar:ClipProgressBar;
      
      public var layout_dmg:ClipLayout;
      
      public function BattleStatisticsPopupTeamMemberClip(param1:Boolean)
      {
         tf_label_dmg = new ClipLabel(true);
         tf_dmg = new ClipLabel(true);
         tf_level = new ClipLabel();
         tf_name = new ClipLabel();
         hero = new MiniHeroPortraitClip();
         progressbar = new ClipProgressBar();
         layout_dmg = ClipLayout.horizontal(4,tf_label_dmg,tf_dmg);
         super();
         this.mirrored = param1;
         if(param1)
         {
            (layout_dmg.layout as HorizontalLayout).horizontalAlign = "left";
         }
         else
         {
            (layout_dmg.layout as HorizontalLayout).horizontalAlign = "right";
         }
      }
      
      public function set data(param1:BattleDamageStatisticsValueObject) : void
      {
         graphics.visible = param1;
         if(param1)
         {
            tf_name.text = param1.name;
            tf_dmg.text = param1.damage.toString();
            tf_level.text = Translate.translateArgs("UI_DIALOG_STATISTICS_LVL_SHORT",param1.level);
            progressbar.value = param1.damage;
            progressbar.maxValue = param1.maxDamage;
            hero.data = param1.hero;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_dmg.text = Translate.translate("UI_DIALOG_STATISTICS_DMG");
         hero.graphics.touchable = false;
      }
   }
}
