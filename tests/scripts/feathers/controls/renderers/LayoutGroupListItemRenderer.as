package feathers.controls.renderers
{
   import feathers.controls.LayoutGroup;
   import feathers.controls.List;
   import feathers.skins.IStyleProvider;
   
   public class LayoutGroupListItemRenderer extends LayoutGroup implements IListItemRenderer
   {
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var _index:int = -1;
      
      protected var _owner:List;
      
      protected var _data:Object;
      
      protected var _isSelected:Boolean;
      
      public function LayoutGroupListItemRenderer()
      {
         super();
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return LayoutGroupListItemRenderer.globalStyleProvider;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      public function get owner() : List
      {
         return this._owner;
      }
      
      public function set owner(param1:List) : void
      {
         if(this._owner == param1)
         {
            return;
         }
         this._owner = param1;
         this.invalidate("data");
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
         this.invalidate("data");
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         this.invalidate("selected");
         this.dispatchEventWith("change");
      }
      
      override public function dispose() : void
      {
         this.owner = null;
         super.dispose();
      }
      
      override protected function draw() : void
      {
         var _loc3_:Boolean = this.isInvalid("data");
         var _loc4_:Boolean = this.isInvalid("scroll");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc2_:Boolean = this.isInvalid("layout");
         if(_loc3_)
         {
            this.commitData();
         }
         if(_loc4_ || _loc1_ || _loc2_)
         {
            this._ignoreChildChanges = true;
            this.preLayout();
            this._ignoreChildChanges = false;
         }
         super.draw();
         if(_loc4_ || _loc1_ || _loc2_)
         {
            this._ignoreChildChanges = true;
            this.postLayout();
            this._ignoreChildChanges = false;
         }
      }
      
      protected function preLayout() : void
      {
      }
      
      protected function postLayout() : void
      {
      }
      
      protected function commitData() : void
      {
      }
   }
}
