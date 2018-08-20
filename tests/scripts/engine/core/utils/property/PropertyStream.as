package engine.core.utils.property
{
   import avmplus.getQualifiedClassName;
   
   public class PropertyStream
   {
       
      
      private var _elementType:Class;
      
      private var _listener:Function;
      
      private var _queue:Vector.<*>;
      
      public function PropertyStream(param1:*, param2:* = null)
      {
         super();
         _elementType = param1;
         if(param2 !== null)
         {
            dispatch(param2);
         }
      }
      
      public function get elementType() : Class
      {
         return _elementType;
      }
      
      public function dispatch(param1:*) : void
      {
         if(!param1 is _elementType)
         {
            throw new TypeError(this,"Wrong element type. Expected " + _elementType + " but " + getQualifiedClassName(param1) + " received");
         }
         if(_listener)
         {
            _listener(param1);
         }
         else
         {
            if(_queue == null)
            {
               _queue = new Vector.<_elementType>();
            }
            _queue.push(param1);
         }
      }
      
      public function add(param1:Function) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_listener != null)
         {
            throw new ArgumentError(this,"listener already set");
         }
         if(param1.length != 1)
         {
            throw new ArgumentError(this,"listener should have one argument of PropertyStream elementType");
         }
         _listener = param1;
         if(_queue)
         {
            _loc2_ = _queue.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _listener(_queue[_loc3_]);
               _loc3_++;
            }
            _queue = null;
         }
      }
      
      public function clear() : void
      {
         _listener = null;
      }
   }
}
