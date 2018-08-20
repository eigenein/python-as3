package game.view.popup.tower
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.hero.HeroListItemClipBase;
   
   public class TowerBuffSelectHeroItemClip extends HeroListItemClipBase
   {
       
      
      public var progressbar_hp:ClipProgressBar;
      
      public var progressbar_energy:ClipProgressBar;
      
      public var dead:TowerTeamGatherPopupHeroRendererDeadLabelClip;
      
      public var tf_hero_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public function TowerBuffSelectHeroItemClip()
      {
         tf_hero_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(2,tf_hero_name);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         progressbar_hp.graphics.touchable = false;
         progressbar_energy.graphics.touchable = false;
         layout_name.graphics.touchable = false;
         dead.graphics.touchable = false;
      }
   }
}
