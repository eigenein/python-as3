package game.mechanics.boss.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import starling.core.Starling;
   
   public class BossChestPanelClosedClip extends GuiClipNestedContainer
   {
       
      
      public var constellations_static:GuiAnimation;
      
      public var outer_particles:GuiAnimation;
      
      public var cap:ClipSprite;
      
      public var internal_particles:GuiAnimation;
      
      public var internal_glow:ClipSprite;
      
      public var chest_base:ClipSprite;
      
      public var back_glow:ClipSprite;
      
      public function BossChestPanelClosedClip()
      {
         super();
      }
      
      public function get animationAlpha() : Number
      {
         return constellations_static.graphics.alpha;
      }
      
      public function set animationAlpha(param1:Number) : void
      {
         constellations_static.graphics.alpha = param1;
         outer_particles.graphics.alpha = param1;
         internal_particles.graphics.alpha = param1;
      }
      
      public function play() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function setStatic(param1:Boolean) : void
      {
         constellations_static.graphics.visible = !param1;
         outer_particles.graphics.visible = !param1;
         internal_particles.graphics.visible = !param1;
      }
      
      public function animate() : void
      {
         setStatic(false);
         animationAlpha = 0;
         Starling.juggler.tween(this,1,{"animationAlpha":1});
      }
   }
}
