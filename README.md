# vcl-playground
This is a collection of VCL snippets for addressing commonly encountered issues on Magento / Adobe Commerce with Fastly kept in a repository for quick and easy use and reuse.

Files are added when and if I find an issue requiring re-use (instead of one-offs) of VCL code.  They are not intended to be used together since there is no attempt to ensure there are no crossover / re-use of error codes and updates / changes may be expected if implemented on a live site.

Note: some snippets act in ways to treat symptoms of issues and may cause entirely different ones (such as API re-attempts) which may allow the front-end to appear more responsive and less error prone at the expense of additional load on the backend and degraded stability and performance.  Please do not implement snippets on a live site without proper testing and understanding of the potential impact.