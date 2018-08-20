package haxe.ds
{
   import vm.Token;
   
   public class GenericCell_vm_Token
   {
       
      
      public var next:GenericCell_vm_Token;
      
      public var elt:Token;
      
      public function GenericCell_vm_Token(param1:Token = undefined, param2:GenericCell_vm_Token = undefined)
      {
         elt = param1;
         next = param2;
      }
   }
}
