package engine.core.clipgui
{
   public class GuiClipFactory extends GuiClipFactoryBase
   {
       
      
      public function GuiClipFactory(param1:Boolean = false)
      {
         super();
         _verbose = param1;
      }
      
      public function set createUnimplementedChildren(param1:Boolean) : void
      {
         _createUnimplementedChildren = true;
      }
      
      public function get createUnimplementedChildren() : Boolean
      {
         return _createUnimplementedChildren;
      }
      
      public function set verbose(param1:Boolean) : void
      {
         _verbose = true;
      }
      
      public function get verbose() : Boolean
      {
         return _verbose;
      }
   }
}
