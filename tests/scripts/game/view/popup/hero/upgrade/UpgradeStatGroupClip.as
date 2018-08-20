package game.view.popup.hero.upgrade
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class UpgradeStatGroupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_stat_per_lvl:ClipLabel;
      
      public var tf_stat_scale_before:ClipLabel;
      
      public var tf_stat_scale_after:ClipLabel;
      
      public var tf_stat_total:ClipLabel;
      
      public var ArrowRightSmallIcon_inst0:ClipSprite;
      
      public var layout_text_left:ClipLayout;
      
      public var layout_text_right:ClipLayout;
      
      public function UpgradeStatGroupClip()
      {
         tf_stat_per_lvl = new ClipLabel(true);
         tf_stat_scale_before = new ClipLabel(true);
         tf_stat_scale_after = new ClipLabel(true);
         tf_stat_total = new ClipLabel(true);
         ArrowRightSmallIcon_inst0 = new ClipSprite();
         layout_text_left = ClipLayout.horizontal(10,tf_stat_per_lvl,tf_stat_scale_before);
         layout_text_right = ClipLayout.horizontal(10,tf_stat_scale_after,tf_stat_total);
         super();
         (layout_text_left.layout as HorizontalLayout).horizontalAlign = "right";
      }
   }
}
