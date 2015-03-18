package org.geotools.parameter;


import java.net.URI;
import java.net.URISyntaxException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.media.jai.OperationDescriptor;
import javax.media.jai.RegistryElementDescriptor;
import javax.media.jai.registry.RenderedRegistryMode;

import org.geotools.metadata.iso.citation.CitationImpl;
import org.geotools.metadata.iso.citation.Citations;
import org.geotools.metadata.iso.citation.ContactImpl;
import org.geotools.metadata.iso.citation.OnLineResourceImpl;
import org.geotools.metadata.iso.citation.ResponsiblePartyImpl;
import org.geotools.resources.i18n.ErrorKeys;
import org.geotools.resources.i18n.Errors;
import org.geotools.util.NameFactory;
import org.opengis.metadata.Identifier;
import org.opengis.metadata.citation.Citation;
import org.opengis.metadata.citation.OnLineFunction;
import org.opengis.metadata.citation.ResponsibleParty;
import org.opengis.metadata.citation.Role;
import org.opengis.parameter.ParameterDescriptor;
import org.opengis.referencing.ReferenceIdentifier;
import org.opengis.util.GenericName;
import org.opengis.util.InternationalString;

public class ExtendedImagingParameterDescriptors extends ImagingParameterDescriptors {

    public ExtendedImagingParameterDescriptors(RegistryElementDescriptor operation,
            Collection<ParameterDescriptor> extension) {
        super(extendedProperties(operation), operation, RenderedRegistryMode.MODE_NAME,
                DEFAULT_SOURCE_TYPE_MAP, extension);
    }
    
    public static Map<String,Object> extendedProperties(final RegistryElementDescriptor operation) {
        String name = operation.getName();
        final Map<String,Object> properties = new HashMap<String,Object>();
        if (operation instanceof OperationDescriptor) {
            /*
             * Gets the vendor name (if available) using US locale in order to get something as
             * close as possible to a kind of "locale-independent" string.  This string will be
             * used in order to remove the prefix (if any) from the global name, for example in
             * "org.geotools.Combine" operation name.  We can remove the prefix because it will
             * appears in the GenericName's scope below (as an alias).
             */
            final OperationDescriptor op = (OperationDescriptor) operation;
            final ResourceBundle bundle = op.getResourceBundle(Locale.getDefault());
            String vendor = op.getResourceBundle(Locale.US).getString("Vendor");
            Citation authority = Citations.JAI;
            
            if (authority == null) {
                /*
                 * jump off, since it will break the creation of CitationImpl
                 * with a missleading "null source" message.
                 */
                throw new IllegalArgumentException(Errors.format(
                        ErrorKeys.NO_SUCH_AUTHORITY_CODE_$2, "AUTHORITIES", vendor));
            }
            /*
             * If we are able to construct an URI, replaces the contact info for the first (and only
             * the first) responsible party. Exactly one responsible party should be presents, since
             * the authority is one of the hard-coded AUTHORITIES list above.  We replace completely
             * the contact info;  for example we do not retain any telephone number because it would
             * be a mismatch with the new URI purpose (this new URI do not links to information that
             * can be used to contact the individual or organisation - it is information about an
             * image operation, and I'm not sure that anyone wants to phone to an image operation).
             */
            final InternationalString description;
            description = new ImagingParameterDescription(op, "Description", null);
            try {
                final URI uri = new URI(bundle.getString("DocURL"));
                final OnLineResourceImpl resource = new OnLineResourceImpl(uri);
                resource.setFunction(OnLineFunction.INFORMATION);
                resource.setDescription(description);
                final CitationImpl citation = new CitationImpl(authority);
                final Collection<ResponsibleParty> parties = citation.getCitedResponsibleParties();
                final ResponsibleParty oldParty;
                if (true) {
                    final Iterator<ResponsibleParty> it = parties.iterator();
                    if (it.hasNext()) {
                        oldParty = it.next();
                        it.remove(); // This party will be re-injected with a new URI below.
                    }
                    else {
                        oldParty = null;
                    }
                }
                final ResponsiblePartyImpl party = new ResponsiblePartyImpl(oldParty);
                party.setRole(Role.RESOURCE_PROVIDER);
                party.setContactInfo(new ContactImpl(resource));
                parties.add(party);
                authority = (Citation) citation.unmodifiable();
            } catch (URISyntaxException exception) {
                // Invalid URI syntax. Ignore, since this property
                // was really just for information purpose.
            }
            /*
             * At this point, all properties have been created. Stores them in the map.
             * The name should be stored as a String (not as an Identifier), otherwise
             * the version and the authority would be ignored. For JAI image operation,
             * the end result is fully-qualified name like "JAI:Add" and one alias like
             * "com.sun.media.jai.Add".
             */
            final GenericName alias = NameFactory.create(new InternationalString[] {
                new ImagingParameterDescription(op, "Vendor"   , null),     // Scope name
                new ImagingParameterDescription(op, "LocalName", "Vendor")  // Local name
            }, '.');
            properties.put(ALIAS_KEY,   alias);
            properties.put(REMARKS_KEY, description);
            properties.put(ReferenceIdentifier.VERSION_KEY, bundle.getString("Version"));
            properties.put(Identifier.AUTHORITY_KEY, authority);
        }
        properties.put(NAME_KEY, name);
        return properties;
    }

}
