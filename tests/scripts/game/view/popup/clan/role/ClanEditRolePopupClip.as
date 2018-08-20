package game.view.popup.clan.role
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ClanEditRolePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var bg:GuiClipScale9Image;
      
      public var button_rank_1:ClipButtonLabeled;
      
      public var button_rank_2:ClipButtonLabeled;
      
      public var button_rank_3:ClipButtonLabeled;
      
      public var layout_buttons:ClipLayout;
      
      public var tf_rank_1:ClipLabel;
      
      public var tf_rank_2:ClipLabel;
      
      public var tf_rank_3:ClipLabel;
      
      public var tf_rank_4:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_message:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var role_info:Vector.<ClanRolePopupItemRendererClip>;
      
      public var bg_bottom:GuiClipScale9Image;
      
      public var layout_main:ClipLayout;
      
      public var layout_bottom:ClipLayout;
      
      public function ClanEditRolePopupClip()
      {
         button_close = new ClipButton();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         button_rank_1 = new ClipButtonLabeled();
         button_rank_2 = new ClipButtonLabeled();
         button_rank_3 = new ClipButtonLabeled();
         layout_buttons = ClipLayout.horizontalMiddleCentered(6,button_rank_1,button_rank_2,button_rank_3);
         tf_rank_1 = new ClipLabel();
         tf_rank_2 = new ClipLabel();
         tf_rank_3 = new ClipLabel();
         tf_rank_4 = new ClipLabel();
         tf_level = new ClipLabel();
         tf_message = new ClipLabel();
         tf_nickname = new ClipLabel();
         portrait = new PlayerPortraitClip();
         role_info = new Vector.<ClanRolePopupItemRendererClip>();
         bg_bottom = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_main = ClipLayout.vertical(4);
         layout_bottom = ClipLayout.none(tf_level,tf_message,tf_nickname,bg_bottom,layout_buttons);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         var _loc2_:int = role_info.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            layout_main.addChild(role_info[_loc3_].graphics);
            _loc3_++;
         }
      }
   }
}
