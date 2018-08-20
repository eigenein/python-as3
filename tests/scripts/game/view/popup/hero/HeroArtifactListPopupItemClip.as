package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.artifacts.PlayerHeroArtifactMiniItemRenderer;
   
   public class HeroArtifactListPopupItemClip extends HeroListItemClipBase
   {
       
      
      public var artifact:Vector.<PlayerHeroArtifactMiniItemRenderer>;
      
      public var NewIcon_inst0:ClipSprite;
      
      public var tf_hero_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public function HeroArtifactListPopupItemClip()
      {
         artifact = new Vector.<PlayerHeroArtifactMiniItemRenderer>();
         tf_hero_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(2,tf_hero_name);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         marker_hero_portrait_inst0.graphics.touchable = false;
         layout_name.graphics.touchable = false;
         _loc2_ = 0;
         while(_loc2_ < artifact.length)
         {
            artifact[_loc2_].graphics.touchable = false;
            _loc2_++;
         }
      }
   }
}
