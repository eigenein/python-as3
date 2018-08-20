package game.view.popup.hero.consumable
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.hero.HeroListItemClipBase;
   
   public class HeroListDialogConsumableItemClip extends HeroListItemClipBase
   {
       
      
      public var tf_xp:ClipLabel;
      
      public var tf_xp_label:ClipLabel;
      
      public var layout_xp:ClipLayout;
      
      public var tf_hero_lvl:ClipLabel;
      
      public var tf_hero_name1:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public var xp_progressbar:ClipProgressBar;
      
      public function HeroListDialogConsumableItemClip()
      {
         tf_xp = new ClipLabel(true);
         tf_xp_label = new ClipLabel(true);
         layout_xp = ClipLayout.horizontalCentered(4,tf_xp_label,tf_xp);
         tf_hero_lvl = new ClipLabel(true);
         tf_hero_name1 = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(4,tf_hero_name1,tf_hero_lvl);
         xp_progressbar = new ClipProgressBar();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_name.touchable = false;
         layout_xp.touchable = false;
         xp_progressbar.graphics.touchable = false;
      }
   }
}
