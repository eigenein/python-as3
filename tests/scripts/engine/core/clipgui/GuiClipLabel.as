package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import game.view.gui.components.GameLabel;
   import starling.display.DisplayObject;
   import starling.filters.FragmentFilter;
   
   public class GuiClipLabel extends GuiClipObject
   {
       
      
      private var labelInitializer:Function;
      
      protected var _label:GameLabel;
      
      private var _text:String;
      
      public function GuiClipLabel(param1:Function = null)
      {
         super();
         this.labelInitializer = param1;
      }
      
      public function get label() : GameLabel
      {
         return _label;
      }
      
      override public function get graphics() : DisplayObject
      {
         return _label;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         if(label)
         {
            label.text = _text;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         if(labelInitializer)
         {
            _label = labelInitializer();
         }
         else
         {
            _label = GameLabel.size20();
         }
         label.width = param1.clip.bounds.width;
         label.height = param1.clip.bounds.height;
         label.text = text;
         var _loc2_:FragmentFilter = label.filter;
         label.filter = null;
         StarlingClipNode.applyState(graphics,param1.state);
         if(label.filter)
         {
            label.filter.dispose();
         }
         label.filter = _loc2_;
      }
   }
}
