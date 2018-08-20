package game.view.gui.components
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.util.PropertyMapManager;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipFactory;
   import feathers.controls.List;
   import feathers.controls.renderers.IListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class ClipList extends GuiClipContainer
   {
       
      
      private var guiClipFactory:GuiClipFactory;
      
      private var itemClass;
      
      private var signals;
      
      private var _itemClipProvider:ClipDataProvider;
      
      public var list:List;
      
      public const signal_itemSelected:Signal = new Signal(Object);
      
      public function ClipList(param1:*, param2:* = null)
      {
         super();
         PropertyMapManager.implementsInterface(param1,getQualifiedClassName(IClipListItem));
         this.itemClass = param1;
         this.signals = param2;
         guiClipFactory = new GuiClipFactory();
         _itemClipProvider = new ClipDataProvider();
      }
      
      public function get itemClipProvider() : ClipDataProvider
      {
         return _itemClipProvider;
      }
      
      public function set itemClipProvider(param1:ClipDataProvider) : void
      {
         _itemClipProvider = param1;
      }
      
      public function set context(param1:Object) : void
      {
         signals = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         if(!list)
         {
            list = listFactory();
         }
         _container = list;
         list.itemRendererFactory = itemRendererFactoryMethod;
         graphics.width = param1.clip.bounds.width;
         graphics.height = param1.clip.bounds.height;
         super.setNode(param1);
      }
      
      protected function itemRendererFactoryMethod() : IListItemRenderer
      {
         var _loc1_:* = null;
         if(signals)
         {
            _loc1_ = new itemClass(signals);
         }
         else
         {
            _loc1_ = new itemClass();
         }
         guiClipFactory.create(_loc1_,_itemClipProvider.clip);
         var _loc2_:Signal = _loc1_.signal_select;
         if(_loc2_)
         {
            _loc2_.add(onItemSelected);
         }
         return new ClipListItemRenderer(_loc1_);
      }
      
      protected function listFactory() : List
      {
         return new List();
      }
      
      protected function onItemSelected(param1:*) : void
      {
         signal_itemSelected.dispatch(param1);
      }
   }
}
