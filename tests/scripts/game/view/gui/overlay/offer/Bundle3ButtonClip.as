package game.view.gui.overlay.offer
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.IGuiClip;
   import game.view.gui.components.ClipLabel;
   import starling.filters.ColorMatrixFilter;
   
   public class Bundle3ButtonClip extends SideBarButton
   {
       
      
      public var tf_time:ClipLabel;
      
      public var tf_txt_line:ClipLabel;
      
      public var icon_tmp:GuiAnimation;
      
      public function Bundle3ButtonClip()
      {
         tf_time = new ClipLabel();
         tf_txt_line = new ClipLabel();
         icon_tmp = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc4_:int = 0;
         super.setNode(param1);
         var _loc3_:Vector.<IGuiClip> = new <IGuiClip>[icon_tmp,tf_txt_line,tf_time];
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            layout_hitArea.addChild(_loc3_[_loc4_].graphics);
            _loc4_++;
         }
         tf_txt_line.text = Translate.translate("UI_BUNDLE_LINE_HERO");
      }
      
      override public function updateTime(param1:String) : void
      {
         tf_time.text = param1;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
         }
      }
   }
}
