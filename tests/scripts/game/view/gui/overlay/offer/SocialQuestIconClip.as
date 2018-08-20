package game.view.gui.overlay.offer
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipLabel;
   import starling.filters.ColorMatrixFilter;
   
   public class SocialQuestIconClip extends SideBarButton
   {
       
      
      public var animation:GuiAnimation;
      
      public var tf_free:ClipLabel;
      
      public var flag_sprite:ClipSprite;
      
      public function SocialQuestIconClip()
      {
         animation = new GuiAnimation();
         tf_free = new ClipLabel();
         flag_sprite = new ClipSprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_free.text = Translate.translate("UI_SOCIAL_QUEST_FREE");
         layout_hitArea.addChild(animation.graphics);
         layout_hitArea.addChild(flag_sprite.graphics);
         layout_hitArea.addChild(tf_free);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            if(flag_sprite && flag_sprite.graphics)
            {
               flag_sprite.graphics.filter = _loc3_;
            }
         }
         else if(animation && animation.graphics)
         {
            if(flag_sprite.graphics.filter)
            {
               flag_sprite.graphics.filter.dispose();
            }
            flag_sprite.graphics.filter = null;
         }
      }
   }
}
