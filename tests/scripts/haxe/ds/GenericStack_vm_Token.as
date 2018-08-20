package haxe.ds
{
   import vm.Token;
   
   public class GenericStack_vm_Token
   {
       
      
      public var head:GenericCell_vm_Token;
      
      public function GenericStack_vm_Token()
      {
      }
      
      public function toString() : String
      {
         var _loc1_:Array = [];
         var _loc2_:GenericCell_vm_Token = head;
         while(_loc2_ != null)
         {
            _loc1_.push(_loc2_.elt);
            _loc2_ = _loc2_.next;
         }
         return "{" + _loc1_.join(",") + "}";
      }
      
      public function remove(param1:Token) : Boolean
      {
         var _loc2_:GenericCell_vm_Token = null;
         var _loc3_:GenericCell_vm_Token = head;
         while(_loc3_ != null)
         {
            if(_loc3_.elt == param1)
            {
               if(_loc2_ == null)
               {
                  head = _loc3_.next;
               }
               else
               {
                  _loc2_.next = _loc3_.next;
               }
               break;
            }
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
         return _loc3_ != null;
      }
      
      public function pop() : Token
      {
         var _loc1_:GenericCell_vm_Token = head;
         if(_loc1_ == null)
         {
            return null;
         }
         head = _loc1_.next;
         return _loc1_.elt;
      }
      
      public function iterator() : Object
      {
         var l:GenericCell_vm_Token = head;
         return {
            "hasNext":function():Boolean
            {
               return l != null;
            },
            "next":function():Token
            {
               var _loc1_:GenericCell_vm_Token = l;
               l = _loc1_.next;
               return _loc1_.elt;
            }
         };
      }
      
      public function isEmpty() : Boolean
      {
         return head == null;
      }
      
      public function first() : Token
      {
         if(head == null)
         {
            return null;
         }
         return head.elt;
      }
      
      public function add(param1:Token) : void
      {
         head = new GenericCell_vm_Token(param1,head);
      }
   }
}
