package game.assets.storage.rsx
{
   import com.progrestar.framework.ares.core.Clip;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.tutorial.dialogs.TutorialMessageClip;
   
   public class TutorialGuiAsset extends RsxGuiAsset
   {
      
      public static const IDENT:String = "dialog_tutorial";
       
      
      public function TutorialGuiAsset(param1:*)
      {
         super(param1);
      }
      
      public function create_tutorialMessageLeft() : TutorialMessageClip
      {
         var _loc1_:TutorialMessageClip = new TutorialMessageClip();
         _factory.create(_loc1_,data.getClipByName("tutorial_message_left"));
         return _loc1_;
      }
      
      public function create_tutorialMessageRight() : TutorialMessageClip
      {
         var _loc1_:TutorialMessageClip = new TutorialMessageClip();
         _factory.create(_loc1_,data.getClipByName("tutorial_message_right"));
         return _loc1_;
      }
      
      public function create_tutorialMessageLeftBig() : TutorialMessageClip
      {
         var _loc1_:TutorialMessageClip = new TutorialMessageClip();
         _factory.create(_loc1_,data.getClipByName("tutorial_message_left_big"));
         return _loc1_;
      }
      
      public function create_tutorialMessageRightBig() : TutorialMessageClip
      {
         var _loc1_:TutorialMessageClip = new TutorialMessageClip();
         _factory.create(_loc1_,data.getClipByName("tutorial_message_right_big"));
         return _loc1_;
      }
      
      public function create_tutorialMessageBubble() : TutorialMessageClip
      {
         var _loc1_:TutorialMessageClip = new TutorialMessageClip();
         _factory.create(_loc1_,data.getClipByName("tutorial_message_left_bubble"));
         return _loc1_;
      }
      
      public function create_tutorialMessage(param1:Boolean, param2:Boolean) : TutorialMessageClip
      {
         var _loc3_:TutorialMessageClip = new TutorialMessageClip();
         _factory.create(_loc3_,data.getClipByName("tutorial_message_" + (!!param1?"right":"left") + (!!param2?"_big":"")));
         return _loc3_;
      }
      
      public function getIcon(param1:String) : ClipSprite
      {
         var _loc2_:ClipSprite = new ClipSprite();
         var _loc3_:Clip = data.getClipByName("icon_" + param1);
         if(_loc3_)
         {
            _factory.create(_loc2_,_loc3_);
         }
         return _loc2_;
      }
   }
}
