package game.view.popup.friends.referrer
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.friends.SearchableFriendListPopupClipBase;
   
   public class ReferrerPopupClip extends SearchableFriendListPopupClipBase
   {
       
      
      public var button_no_one:ClipButtonLabeled;
      
      public var tf_caption:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_no_one_desc:ClipLabel;
      
      public function ReferrerPopupClip()
      {
         button_no_one = new ClipButtonLabeled();
         tf_caption = new ClipLabel();
         tf_header = new ClipLabel();
         tf_no_one_desc = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:Boolean = false;
         gradient_top.graphics.touchable = _loc2_;
         gradient_bottom.graphics.touchable = _loc2_;
      }
   }
}
