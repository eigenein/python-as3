package game.mediator.gui.tooltip
{
   import flash.utils.Dictionary;
   
   public class TooltipNode
   {
      
      private static var _ids:uint = 0;
       
      
      public var id:uint;
      
      public var branchOvered:Boolean;
      
      public var parent:TooltipNode;
      
      public var children:Dictionary;
      
      public var source:ITooltipSource;
      
      public var view:ITooltipView;
      
      private var _viewOvered:Boolean;
      
      private var _sourceOvered:Boolean;
      
      public function TooltipNode()
      {
         children = new Dictionary();
         super();
         id = _ids;
         _ids = Number(_ids) + 1;
      }
      
      public function get viewOvered() : Boolean
      {
         return _viewOvered;
      }
      
      public function set viewOvered(param1:Boolean) : void
      {
         _viewOvered = param1;
         updateBranch();
      }
      
      public function get sourceOvered() : Boolean
      {
         return _sourceOvered;
      }
      
      public function set sourceOvered(param1:Boolean) : void
      {
         _sourceOvered = param1;
         updateBranch();
      }
      
      public function toString() : String
      {
         return "Node<" + source + "," + view + ">";
      }
      
      private function updateBranch() : void
      {
         branchOvered = _sourceOvered || _viewOvered;
         var _loc1_:TooltipNode = parent;
         while(_loc1_ && !(_loc1_.sourceOvered || _loc1_.viewOvered))
         {
            _loc1_.branchOvered = branchOvered;
            _loc1_ = _loc1_.parent;
         }
      }
   }
}
